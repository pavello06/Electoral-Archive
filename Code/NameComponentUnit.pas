Unit NameComponentUnit;

Interface

Uses
    Winapi.Windows, System.SysUtils, System.Classes, Clipbrd;

Const
    ENTER = #13;
    BACKSPACE = #8;
    NONE = #0;
    ALPHABET = ['A' .. 'Z', 'a' .. 'z'];
    VALID_CHARS = ' -àáâãäå¸æçèéêëìíîïğñòóôõö÷øùúûüışÿabcdefghijklmnopqrstuvwxyzÀÁÂÃÄÅ¨ÆÇÈÉÊËÌÍÎÏĞÑÒÓÔÕÖ×ØÙÚÛÜİŞßABCDEFGHIJKLMNOPQRSTUVWXYZ';

Var
    CtrlPressed: Boolean = False;

Procedure NameComponentContextPopup(Const Text: String; Const SelStart, SelLength, MAX: Integer; Var Handled: Boolean);
Procedure NameComponentExit(Text: String; Const MIN: Integer);
Procedure NameComponentKeyDown(Const Text: String; Const SelStart, SelLength, MAX: Integer; Var Key: Word; Shift: TShiftState);
Procedure NameComponentKeyPress(Const Text: String; Const SelStart, SelLength, MAX: Integer; Var Key: Char);
Procedure NameComponentKeyUp();

Implementation

Function IsValidRange(Const Num, MAX: Integer): Boolean;
Begin
    IsValidRange := Num <= MAX;
End;

Function IsValidChar(Const Key: Char): Boolean;
Var
    C: Char;
Begin
    For C In VALID_CHARS Do
        If C = Key Then
            Exit(True);
    IsValidChar := False;
End;

Function IsValidChars(Const Text: String) : Boolean;
Var
    I: Integer;
Begin
    For I := 1 To Length(Text) Do
        If Not IsValidChar(Text[I]) Then
            Exit(False);
    IsValidChars := True;
End;

Function IsPossiblePaste(Const Text: String; Const SelStart, SelLength, MAX: Integer): Boolean;
Begin
    IsPossiblePaste := Clipboard.HasFormat(CF_TEXT) And
                       (Length(Clipboard.AsText) <> 0) And
                       IsValidChars(Clipboard.AsText) And
                       IsValidRange(Length(Copy(Text, 1, SelStart) + Clipboard.AsText + Copy(Text, SelStart + SelLength + 1)), MAX);
End;


Procedure NameComponentContextPopup(Const Text: String; Const SelStart, SelLength, MAX: Integer; Var Handled: Boolean);
Begin
    If Not IsPossiblePaste(Text, SelStart, SelLength, MAX) Then
        Handled := True;
End;

Procedure NameComponentExit(Text: String; Const MIN: Integer);
Begin
    If Length(Text) < MIN Then 
        Text := '';
End;

Procedure NameComponentKeyDown(Const Text: String; Const SelStart, SelLength, MAX: Integer; Var Key: Word; Shift: TShiftState);
Begin
    If (Shift = [ssCtrl]) And (UpCase(Chr(Key)) = 'V') Or
       (Shift = [ssShift]) And (Key = VK_INSERT) Then
    Begin
        If Not IsPossiblePaste(Text, SelStart, SelLength, MAX) Then
            Key := Ord(NONE);
    End;
    If (Shift = [ssCtrl]) And CharInSet(Chr(Key), ALPHABET) Then
        CtrlPressed := True;
End;

Procedure NameComponentKeyPress(Const Text: String; Const SelStart, SelLength, MAX: Integer; Var Key: Char);
Begin
    If Not CtrlPressed And (Key <> BACKSPACE) Then
    Begin
        If Not (IsValidChar(Key) And IsValidRange(Length(Copy(Text, 1, SelStart) + Key + Copy(Text, SelStart + SelLength + 1)), MAX)) Then
            Key := NONE;
    End;
End;

Procedure NameComponentKeyUp();
Begin
    CtrlPressed := False;
End;

End.
