Unit CandidateListUnit;

Interface

Uses
    System.SysUtils, Vcl.Grids;

Const
    MAX_CANDIDATE_COUNT = 1000000;

    MIN_DISTRICT_NUMBER = 1;
    MAX_DISTRICT_NUMBER = 100000;
    MAX_NAME_LENGTH = 30;
    MAX_PARTY_NAME_LENGTH = 40;
    MIN_AGE = 1;
    MAX_AGE = 100;
    MAX_PROFESSION_NAME_LENGTH = 30;

Type
    TDistrictNumber = Integer;
    TName = String[MAX_NAME_LENGTH];
    TPartyName = String[MAX_PARTY_NAME_LENGTH];
    TAge = Integer;
    TProfessionName = String[MAX_PROFESSION_NAME_LENGTH];

    TCandidateData = Record
        DistrictNumber: TDistrictNumber;
        LastName: TName;
        FirstName: TName;
        Patronymic: TName;
        Party: TPartyName;
        Age: TAge;
        Profession: TProfessionName;
    End;

    PCandidate = ^TCandidate;
    TCandidate = Record
        Data: TCandidateData;
        Next: PCandidate;
    End;

Function CountCandidates(Const CandidateList: PCandidate) : Integer;
Function IsExistCandidate(Const CandidateList: PCandidate; Const CandidateData: TCandidateData): Boolean;
Function IsExistParty(Const CandidateList: PCandidate; Const PartyName: TPartyName): Boolean;

Procedure AddCandidate(Var CandidateList: PCandidate; Const CandidateData: TCandidateData);
Procedure EditCandidate(Const CandidateList: PCandidate; Const OldCandidateData, NewCandidateData: TCandidateData);
Procedure DeleteCandidate(Var CandidateList: PCandidate; Const CandidateData: TCandidateData);
Procedure ClearCandidates(Var CandidateList: PCandidate);

Procedure FillCandidateListStringGrid(CandidateList: PCandidate; CandidateListStringGrid: TStringGrid);
Procedure FillPartyStringGrid(CandidateList: PCandidate; PartyStringGrid: TStringGrid; PartyName: TPartyName);

Implementation

Function CountCandidates(Const CandidateList: PCandidate) : Integer;
Var
    CurrCandidate: PCandidate;
    CandidateCount: Integer;
Begin
    CurrCandidate := CandidateList;
    CandidateCount := 0;
    While CurrCandidate <> Nil Do
    Begin
        Inc(CandidateCount);
        CurrCandidate := CurrCandidate^.Next;
    End;
    CountCandidates := CandidateCount;
End;

Function IsEqualCandidates(Const CandidateData1, CandidateData2: TCandidateData): Boolean;
Begin
    IsEqualCandidates := (CandidateData1.DistrictNumber = CandidateData2.DistrictNumber) And
                         (CandidateData1.LastName = CandidateData2.LastName) And
                         (CandidateData1.FirstName = CandidateData2.FirstName) And
                         (CandidateData1.Patronymic = CandidateData2.Patronymic) And
                         (CandidateData1.Party = CandidateData2.Party) And
                         (CandidateData1.Age = CandidateData2.Age) And
                         (CandidateData1.Profession = CandidateData2.Profession);
End;

Function SearchCandidate(Const CandidateList: PCandidate; Const CandidateData: TCandidateData) : PCandidate;
Var
    CurrCandidate: PCandidate;
Begin
    CurrCandidate := CandidateList;
    While Not IsEqualCandidates(CurrCandidate^.Data, CandidateData) Do
        CurrCandidate := CurrCandidate^.Next;
    SearchCandidate := CurrCandidate;
End;

Function IsExistCandidate(Const CandidateList: PCandidate; Const CandidateData: TCandidateData): Boolean;
Var
    CurrCandidate: PCandidate;
    IsExist: Boolean;
Begin
    CurrCandidate := CandidateList;
    IsExist := False;
    If CurrCandidate <> Nil Then
        Repeat
            IsExist := IsEqualCandidates(CurrCandidate^.Data, CandidateData);
            CurrCandidate := CurrCandidate^.Next;
        Until IsExist Or (CurrCandidate = Nil);
    IsExistCandidate := IsExist;
End;

Function IsExistParty(Const CandidateList: PCandidate; Const PartyName: TPartyName): Boolean;
Var
    CurrCandidate: PCandidate;
    IsExist: Boolean;
Begin
    CurrCandidate := CandidateList;
    IsExist := False;
    If CurrCandidate <> Nil Then
        Repeat
            IsExist := CurrCandidate^.Data.Party = PartyName;
            CurrCandidate := CurrCandidate^.Next;
        Until IsExist Or (CurrCandidate = Nil);
    IsExistParty := IsExist;
End;


Function CreateCandidate(Const CandidateData: TCandidateData): PCandidate;
Var
    NewCandidate: PCandidate;
Begin
    New(NewCandidate);
    NewCandidate^.Data := CandidateData;
    NewCandidate^.Next := Nil;
    CreateCandidate := NewCandidate;
End;

Procedure AddCandidate(Var CandidateList: PCandidate; Const CandidateData: TCandidateData);
Var
    NewCandidate, CurrCandidate: PCandidate;
Begin
    NewCandidate := CreateCandidate(CandidateData);
    If CandidateList = Nil Then
        CandidateList := NewCandidate
    Else
    Begin
        CurrCandidate := CandidateList;
        While CurrCandidate^.Next <> Nil Do
            CurrCandidate := CurrCandidate^.Next;
        CurrCandidate^.Next := NewCandidate;
    End;
End;

Procedure EditCandidate(Const CandidateList: PCandidate; Const OldCandidateData, NewCandidateData: TCandidateData);
Var
    CurrCandidate: PCandidate;
Begin
    CurrCandidate := SearchCandidate(CandidateList, OldCandidateData);
    CurrCandidate^.Data := NewCandidateData;
End;

Procedure DeleteCandidate(Var CandidateList: PCandidate; Const CandidateData: TCandidateData);
Var
    CurrCandidate, TempCandidate: PCandidate;
Begin
    CurrCandidate := CandidateList;
    If IsEqualCandidates(CurrCandidate^.Data, CandidateData) Then
    Begin
        CandidateList := CurrCandidate^.Next;
        Dispose(CurrCandidate);
    End
    Else
    Begin
        While Not IsEqualCandidates(CurrCandidate^.Next^.Data, CandidateData) Do
            CurrCandidate := CurrCandidate^.Next;
        TempCandidate := CurrCandidate^.Next;
        CurrCandidate^.Next := CurrCandidate^.Next^.Next;
        Dispose(TempCandidate);
    End;
End;

Procedure ClearCandidates(Var CandidateList: PCandidate);
Var
    CurrCandidate, TempCandidate: PCandidate;
Begin
    CurrCandidate := CandidateList;
    While CurrCandidate <> Nil Do
    Begin
        TempCandidate := CurrCandidate;
        CurrCandidate := CurrCandidate^.Next;
        Dispose(TempCandidate);
    End;
    CandidateList := Nil;
End;


Procedure FillCandidateListStringGrid(CandidateList: PCandidate; CandidateListStringGrid: TStringGrid);
Var
    CurrCandidate: PCandidate;
    CurrRow: Integer;
Begin
    CurrCandidate := CandidateList;
    CurrRow := 1;
    While CurrCandidate <> Nil Do
    Begin
        With CandidateListStringGrid, CurrCandidate^.Data Do
        Begin
            Cells[0, CurrRow] := IntToStr(DistrictNumber);
            Cells[1, CurrRow] := String(LastName);
            Cells[2, CurrRow] := String(FirstName);
            Cells[3, CurrRow] := String(Patronymic);
            Cells[4, CurrRow] := String(Party);
            Cells[5, CurrRow] := IntToStr(Age);
            Cells[6, CurrRow] := String(Profession);
        End;
        Inc(CurrRow);
        CurrCandidate := CurrCandidate^.Next;
    End;
End;

Procedure FillPartyStringGrid(CandidateList: PCandidate; PartyStringGrid: TStringGrid; PartyName: TPartyName);
Var
    CurrCandidate: PCandidate;
    CurrRow: Integer;
Begin
    CurrCandidate := CandidateList;
    PartyStringGrid.RowCount := 1;
    CurrRow := 1;
    While CurrCandidate <> Nil Do
    Begin
        If CurrCandidate^.Data.Party = PartyName Then
        Begin
            With PartyStringGrid, CurrCandidate^.Data Do
            Begin
                RowCount := CurrRow + 1;
                Cells[0, CurrRow] := IntToStr(DistrictNumber);
                Cells[1, CurrRow] := String(LastName);
                Cells[2, CurrRow] := String(FirstName);
                Cells[3, CurrRow] := String(Patronymic);
                Cells[4, CurrRow] := IntToStr(Age);
                Cells[5, CurrRow] := String(Profession);
            End;
            Inc(CurrRow);
        End;
        CurrCandidate := CurrCandidate^.Next;
    End;
End;

End.
