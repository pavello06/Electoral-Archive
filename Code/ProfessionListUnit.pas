Unit ProfessionListUnit;

Interface

Uses
    CandidateListUnit;

Type
    TProfessionData = Record
        ProfessionName: TProfessionName;
        Count: Integer;
    End;

    PProfession = ^TProfession;
    TProfession = Record
        Data: TProfessionData;
        Next: PProfession;
    End;

Procedure AddProfession(Var ProfessionList: PProfession; ProfessionName: TProfessionName);
Procedure ClearProfessions(Var ProfessionList: PProfession);

Function FindPopularProfession(ProfessionList: PProfession) : TProfessionName;

Implementation

Function CreateProfession(ProfessionName: TProfessionName) : PProfession;
Var
    NewProfession: PProfession;
Begin
    New(NewProfession);
    NewProfession^.Data.ProfessionName := ProfessionName;
    NewProfession^.Data.Count := 1;
    NewProfession^.Next := Nil;
    CreateProfession := NewProfession;
End;

Procedure AddProfession(Var ProfessionList: PProfession; ProfessionName: TProfessionName);
Var
    NewProfession, CurrProfession: PProfession;
Begin
    NewProfession := CreateProfession(ProfessionName);
    If ProfessionList = Nil Then
        ProfessionList := NewProfession
    Else
    Begin
        CurrProfession := ProfessionList;
        While (CurrProfession^.Next <> Nil) And (CurrProfession^.Data.ProfessionName <> ProfessionName) Do
            CurrProfession := CurrProfession^.Next;
        If CurrProfession^.Data.ProfessionName = ProfessionName Then
            Inc(CurrProfession.Data.Count)
        Else
            CurrProfession^.Next := NewProfession;
    End;
End;

Procedure ClearProfessions(Var ProfessionList: PProfession);
Var
    CurrProfession, TempProfession: PProfession;
Begin
    CurrProfession := ProfessionList;
    While CurrProfession <> Nil Do
    Begin
        TempProfession := CurrProfession;
        CurrProfession := CurrProfession^.Next;
        Dispose(TempProfession);
    End;
    ProfessionList := Nil;
End;


Function FindPopularProfession(ProfessionList: PProfession) : TProfessionName;
Var
    CurrProfession: PProfession;
    PopularProfessionData: TProfessionData;
Begin
    CurrProfession := ProfessionList;
    PopularProfessionData := CurrProfession^.Data;
    While CurrProfession <> Nil Do
    Begin
        If PopularProfessionData.Count < CurrProfession^.Data.Count Then
            PopularProfessionData := CurrProfession^.Data;
        CurrProfession := CurrProfession^.Next;
    End;
    FindPopularProfession := PopularProfessionData.ProfessionName;
End;

End.
