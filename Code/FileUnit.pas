Unit FileUnit;

Interface

Uses
    Vcl.Grids,
    CandidateListUnit;

Type
    TCandidateDataFile = File Of TCandidateData;

Function ReadFileData(Var InputFile: TCandidateDataFile; Var TempCandidateList: PCandidate): Boolean;
Procedure RecordFileData(Var CandidateList: PCandidate; Const TempCandidateList: PCandidate; CandidateListStringGrid: TStringGrid);
Procedure WriteFileData(Var OutputFile: TCandidateDataFile; Const CandidateList: PCandidate);

Implementation

Function IsCorrectFileData(Const TempCandidateData: TCandidateData) : Boolean;
Begin
    With TempCandidateData Do
        IsCorrectFileData := (DistrictNumber >= MIN_DISTRICT_NUMBER) And (DistrictNumber <= MAX_DISTRICT_NUMBER) And
                             (Length(LastName) >= 1) And (Length(LastName) <= MAX_NAME_LENGTH) And
                             (Length(FirstName) >= 1) And (Length(FirstName) <= MAX_NAME_LENGTH) And
                             (Length(Patronymic) <= MAX_NAME_LENGTH) And
                             (Length(Party) >= 1) And (Length(Party) <= MAX_PARTY_NAME_LENGTH) And
                             (Age >= MIN_AGE) And (Age <= MAX_AGE) And
                             (Length(Profession) >= 1) And (Length(Profession) <= MAX_PROFESSION_NAME_LENGTH);
End;

Function ReadFileData(Var InputFile: TCandidateDataFile; Var TempCandidateList: PCandidate): Boolean;
Var
    IsCorrect: Boolean;
    CandidateCount: Integer;
    TempCandidateData: TCandidateData;
Begin
    Reset(InputFile);
    IsCorrect := True;
    CandidateCount := 0;
    While IsCorrect And (CandidateCount < MAX_CANDIDATE_COUNT) And Not EOF(InputFile) Do
    Begin
        Read(InputFile, TempCandidateData);
        IsCorrect := IsCorrectFileData(TempCandidateData) And Not IsExistCandidate(TempCandidateList, TempCandidateData);
        If IsCorrect Then
        Begin
            AddCandidate(TempCandidateList, TempCandidateData);
            Inc(CandidateCount);
        End;
    End;
    If IsCorrect Then
        IsCorrect := CandidateCount <= MAX_CANDIDATE_COUNT;
    CloseFile(InputFile);
    ReadFileData := IsCorrect;
End;

Procedure RecordFileData(Var CandidateList: PCandidate; Const TempCandidateList: PCandidate; CandidateListStringGrid: TStringGrid);
Begin
    CandidateList := TempCandidateList;
    CandidateListStringGrid.RowCount := CountCandidates(CandidateList) + 1;
    FillCandidateListStringGrid(CandidateList, CandidateListStringGrid);
End;

Procedure WriteFileData(Var OutputFile: TCandidateDataFile; Const CandidateList: PCandidate);
Var
    CurrCandidate: PCandidate;
Begin
    Rewrite(OutputFile);
    CurrCandidate := CandidateList;
    While CurrCandidate <> Nil Do
    Begin
        Write(OutputFile, CurrCandidate^.Data);
        CurrCandidate := CurrCandidate^.Next;
    End;
    CloseFile(OutputFile);
End;

End.
