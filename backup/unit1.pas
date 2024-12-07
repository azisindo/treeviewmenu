unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs,ComCtrls, ExtCtrls, StdCtrls;


type

  { TForm1 }

  TForm1 = class(TForm)
    TreeView1: TTreeView;
    procedure FormCreate(Sender: TObject);
    procedure TreeView1CustomDraw(Sender: TCustomTreeView; const ARect: TRect;
      var DefaultDraw: Boolean);
    procedure TreeView1CustomDrawItem(Sender: TCustomTreeView; Node: TTreeNode;
      State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure TreeView1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    procedure SetupTreeViewStyle;
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
{var
  RootNode, ChildNode: TTreeNode;
begin}

 var
  RootNode, SubRootNode, ChildNode: TTreeNode;
begin
SetupTreeViewStyle;

  // Root level 0
  RootNode := TreeView1.Items.Add(nil, 'Dashboard');



  // Menu Manajemen
  RootNode := TreeView1.Items.Add(nil, 'Manajemen');

  // Child level 1
  ChildNode := TreeView1.Items.AddChild(RootNode, 'Pengguna');

  // Sub-child level 2
  SubRootNode := TreeView1.Items.AddChild(ChildNode, 'Daftar Pengguna');
  SubRootNode := TreeView1.Items.AddChild(ChildNode, 'Tambah Pengguna');

  // Kembali ke child level 1 lainnya
  ChildNode := TreeView1.Items.AddChild(RootNode, 'Hak Akses');
  SubRootNode := TreeView1.Items.AddChild(ChildNode, 'Role Admin');
  SubRootNode := TreeView1.Items.AddChild(ChildNode, 'Role User');

  // Menu Laporan dengan struktur lebih kompleks
  RootNode := TreeView1.Items.Add(nil, 'Laporan');

  // Child level 1 Laporan
  ChildNode := TreeView1.Items.AddChild(RootNode, 'Laporan Keuangan');
  SubRootNode := TreeView1.Items.AddChild(ChildNode, 'Laporan Bulanan');
  SubRootNode := TreeView1.Items.AddChild(ChildNode, 'Laporan Tahunan');

  // Child level 1 Laporan lainnya
  ChildNode := TreeView1.Items.AddChild(RootNode, 'Laporan Operasional');
  SubRootNode := TreeView1.Items.AddChild(ChildNode, 'Laporan Harian');
  SubRootNode := TreeView1.Items.AddChild(ChildNode, 'Laporan Mingguan');

  // Menu Pengaturan
  RootNode := TreeView1.Items.Add(nil, 'Pengaturan');

  // Child level 1 Pengaturan
  ChildNode := TreeView1.Items.AddChild(RootNode, 'Profil');
  SubRootNode := TreeView1.Items.AddChild(ChildNode, 'Edit Profil');
  SubRootNode := TreeView1.Items.AddChild(ChildNode, 'Keamanan');

  ChildNode := TreeView1.Items.AddChild(RootNode, 'Aplikasi');
  SubRootNode := TreeView1.Items.AddChild(ChildNode, 'Umum');
  SubRootNode := TreeView1.Items.AddChild(ChildNode, 'Tampilan');

  // Expand semua root node
  for RootNode in TreeView1.Items do
    if RootNode.Level = 0 then
      RootNode.Expanded := True;

    TreeView1.OnMouseMove := @TreeView1MouseMove;
    TreeView1.OnCustomDrawItem := @TreeView1CustomDrawItem;
end;

procedure TForm1.TreeView1CustomDraw(Sender: TCustomTreeView;
  const ARect: TRect; var DefaultDraw: Boolean);
var
//  Canvas: TCanvas;
  Rect: TRect;
begin
 { Canvas := Sender.Canvas;
  Rect := Node.DisplayRect(True);

  // Hapus background default
  Canvas.Brush.Style := bsClear;

  // Efek hover dan selection
  if cdHot in State then
  begin
    Canvas.Brush.Color := RGB(240, 240, 240);
    Canvas.FillRect(Rect);
  end;

  if cdSelected in State then
  begin
    Canvas.Brush.Color := RGB(220, 230, 250);
    Canvas.FillRect(Rect);
  end;

  // Render teks dengan warna yang lebih halus
  if Node.Level = 0 then
  begin
    Canvas.Font.Style := [fsBold];
    Canvas.Font.Color := RGB(50, 50, 50);
  end
  else
  begin
    Canvas.Font.Style := [];
    Canvas.Font.Color := RGB(80, 80, 80);
  end;
                         }
  DefaultDraw := True;

end;

procedure TForm1.TreeView1CustomDrawItem(Sender: TCustomTreeView;
  Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
{var
  Rect: TRect;
begin
  Canvas := Sender.Canvas;
  Rect := Node.DisplayRect(True);

  // Hapus background default
  Canvas.Brush.Style := bsSolid;

 // Cek selected secara manual
  if (Sender as TTreeView).Selected = Node then
  begin
    Canvas.Brush.Color :=  $00B4B4FF;
    Canvas.FillRect(Rect);
  end
  else
  begin
    Canvas.Brush.Color := clWhite;
    Canvas.FillRect(Rect);
  end;

  // Styling teks
  if Node.Level = 0 then
  begin
    Canvas.Font.Style := [fsBold];
    Canvas.Font.Color := clBlack;
  end
  else
  begin
    Canvas.Font.Style := [fsItalic];
    Canvas.Font.Color := clRed;
  end;

  DefaultDraw := True;  }
var
  //Canvas: TCanvas;
  Rect: TRect;
  MousePos: TPoint;
  HoveredNode: TTreeNode;
begin
  Canvas := Sender.Canvas;
  Rect := Node.DisplayRect(True);

  // Dapatkan node yang sedang di-hover
  MousePos := Mouse.CursorPos;
  //MousePos := TreeView1.ScreenToClient(MousePos);
 // HoveredNode := TreeView1.GetNodeAt(MousePos.X, MousePos.Y);

 // Canvas.Brush.Style := bsSolid;

 { // Cek hover
  if HoveredNode = Node then
  begin
    Canvas.Brush.Color := clGrayText; // Warna abu-abu muda untuk hover
    Canvas.FillRect(Rect);
  end
  // Cek selected
  else if (Sender as TTreeView).Selected = Node then
  begin
    Canvas.Brush.Color := $00B4B4FF; // Warna biru muda untuk selected
    Canvas.FillRect(Rect);
  end
  else
  begin
    Canvas.Brush.Color := clGreen;
    Canvas.FillRect(Rect);
  end;

  // Styling teks
 if Node.Level = 0 then
begin
  Canvas.Font.Style := [fsBold];
  Canvas.Font.Color := clBlack;
end
else if Node.Level = 1 then
begin
  Canvas.Font.Style := [fsItalic];
  Canvas.Font.Color := clRed;
end
else
begin
  Canvas.Font.Style := [];
  Canvas.Font.Color := clBlue;
end;

  DefaultDraw := True;        }

  case Node.Level of
     0: Canvas.Brush.Color := $00F0F0F0;  // Abu-abu terang untuk root
     1: Canvas.Brush.Color := $00E0E0FF;  // Merah muda untuk child
     2: Canvas.Brush.Color := $00FFE0E0;  // Biru muda untuk sub-child
     else Canvas.Brush.Color := clWhite;
   end;

   Canvas.FillRect(Rect);

   // Warna teks berbeda berdasarkan level
   case Node.Level of
     0: begin
          Canvas.Font.Style := [fsBold];
          Canvas.Font.Color := clMaroon;
        end;
     1: begin
          Canvas.Font.Style := [fsItalic];
          Canvas.Font.Color := clNavy;
        end;
     2: begin
          Canvas.Font.Style := [fsUnderline];
          Canvas.Font.Color := clTeal;
        end;
     else begin
          Canvas.Font.Style := [];
          Canvas.Font.Color := clGray;
        end;
   end;

   DefaultDraw := True;
end;

procedure TForm1.TreeView1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  Node: TTreeNode;
begin
  Node := TreeView1.GetNodeAt(X, Y);
  if Node <> nil then
  begin
    TreeView1.Invalidate; // Memaksa redraw
  end;
end;

procedure TForm1.SetupTreeViewStyle;
begin
   // Styling modern dan bersih
  //TreeView1.Color := clWhite;//RGB(250, 250, 250);  // Putih lembut
  TreeView1.Font.Name := 'Segoe UI';      // Font modern
  TreeView1.Font.Size := 10;
  TreeView1.BorderStyle := bsNone;        // Hilangkan border

  // Aktifkan custom draw untuk tampilan lebih baik
//  TreeView1.OnCustomDrawItem := @TreeView1CustomDrawItem;

  // Tambahkan efek
 // TreeView1.Options := TreeView1.Options + [tvoHideSelection];
end;

end.

