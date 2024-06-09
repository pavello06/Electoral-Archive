program ElectoralArchive;

uses
  Vcl.Forms,
  MenuUnit in 'MenuUnit.pas' {MenuForm},
  ViewCandidateListUnit in 'ViewCandidateListUnit.pas' {ViewCandidateListForm},
  ModifyCandidateUnit in 'ModifyCandidateUnit.pas' {ModifyCandidateForm},
  Vcl.Themes,
  Vcl.Styles,
  CandidateListUnit in 'CandidateListUnit.pas',
  PositiveNumberComponentUnit in 'PositiveNumberComponentUnit.pas',
  NameComponentUnit in 'NameComponentUnit.pas',
  PartyListUnit in 'PartyListUnit.pas',
  ProfessionListUnit in 'ProfessionListUnit.pas',
  SearchUnit in 'SearchUnit.pas' {SearchForm},
  PartyUnit in 'PartyUnit.pas' {PartyForm},
  FileUnit in 'FileUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Windows10');
  Application.CreateForm(TMenuForm, MenuForm);
  Application.CreateForm(TViewCandidateListForm, ViewCandidateListForm);
  Application.CreateForm(TModifyCandidateForm, ModifyCandidateForm);
  Application.CreateForm(TSearchForm, SearchForm);
  Application.CreateForm(TPartyForm, PartyForm);
  Application.Run;
end.
