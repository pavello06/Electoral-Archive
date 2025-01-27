Unit PartyListUnit;

Interface

Uses
    System.SysUtils, Vcl.Grids,
    CandidateListUnit,
    ProfessionListUnit;

Type
    TApplicationCount = Integer;
    TAge = Integer;

    TPartyData = Record
        PartyName: TPartyName;
        ApplicationCount: TApplicationCount;
        Age: TAge;
        ProfessionList: PProfession;
    End;

    PParty = ^TParty;
    TParty = Record
        Data: TPartyData;
        Next: PParty;
    End;

Procedure FillBulletinStringGrid(CandidateList: PCandidate; BulletinStringGrid: TStringGrid);

Implementation

Function CreateParty(CandidateData: TCandidateData) : PParty;
Var
    NewParty: PParty;
Begin
    New(NewParty);
    NewParty^.Data.PartyName := CandidateData.Party;
    NewParty^.Data.ApplicationCount := 1;
    NewParty^.Data.Age := CandidateData.Age;
    NewParty^.Data.ProfessionList := Nil;
    AddProfession(NewParty^.Data.ProfessionList, CandidateData.Profession);
    NewParty^.Next := Nil;
    CreateParty := NewParty;
End;

Procedure AddParty(Var PartyList: PParty; CandidateData: TCandidateData);
Var
    NewParty, CurrParty: PParty;
Begin
    NewParty := CreateParty(CandidateData);
    If PartyList = Nil Then
        PartyList := NewParty
    Else
    Begin
        CurrParty := PartyList;
        While (CurrParty^.Next <> Nil) And (CurrParty^.Data.PartyName <> CandidateData.Party) Do
            CurrParty := CurrParty^.Next;
        If CurrParty^.Data.PartyName = CandidateData.Party Then
        Begin
            Inc(CurrParty^.Data.ApplicationCount);
            Inc(CurrParty^.Data.Age, CandidateData.Age);
            AddProfession(CurrParty^.Data.ProfessionList, CandidateData.Profession);
        End
        Else
            CurrParty^.Next := NewParty;
    End;
End;

Procedure ClearParties(Var PartyList: PParty);
Var
    CurrParty, TempParty: PParty;
Begin
    CurrParty := PartyList;
    While CurrParty <> Nil Do
    Begin
        ClearProfessions(CurrParty^.Data.ProfessionList);
        TempParty := CurrParty;
        CurrParty := CurrParty^.Next;
        Dispose(TempParty);
    End;
    PartyList := Nil;
End;


Function CreatePartyList(CandidateList: PCandidate) : PParty;
Var
    CurrCandidate: PCandidate;
    PartyList: PParty;
Begin
    CurrCandidate := CandidateList;
    PartyList := Nil;
    While CurrCandidate <> Nil Do
    Begin
        AddParty(PartyList, CurrCandidate^.Data);
        CurrCandidate := CurrCandidate^.Next;
    End;
    CreatePartyList := PartyList;
End;

Procedure FillBulletinStringGrid(CandidateList: PCandidate; BulletinStringGrid: TStringGrid);
Var
    PartyList: PParty;
    CurrParty: PParty;
    CurrRow: Integer;
Begin
    PartyList := CreatePartyList(CandidateList);
    BulletinStringGrid.RowCount := 1;
    CurrParty := PartyList;
    CurrRow := 1;
    While CurrParty <> Nil Do
    Begin
        With BulletinStringGrid, CurrParty^.Data Do
        Begin
            RowCount := CurrRow + 1;
            Cells[0, CurrRow] := String(PartyName);
            Cells[1, CurrRow] := IntToStr(ApplicationCount);
            Cells[2, CurrRow] := IntToStr(Age Div ApplicationCount);
            Cells[3, CurrRow] := String(FindPopularProfession(ProfessionList));
            CurrParty := CurrParty^.Next;
        End;
        Inc(CurrRow);
    End;
    ClearParties(PartyList);
End;

End.
