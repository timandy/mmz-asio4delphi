unit untMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UntRmodbSvr, ImgList, ComCtrls;

type
  Tfrm_main = class(TForm)
    lvLog: TListView;
    ImageListLogLevel: TImageList;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_main: Tfrm_main;

implementation
uses
  UntTIO, untFunctions, untCfger;

{$R *.dfm}

var
  Gio: TIOer; //日志对象 可显示和记录日志信息

procedure Tfrm_main.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  //创建日志对象
  Gio := TIOer.Create(lvLog, GetCurrPath + 'log\');
//  Gio.Enabled:=false;
  //创建数据服务器对象 使用9200端口
  Gob_RmoDBsvr := TRmodbSvr.Create(9200, Gio);
  {$ifdef dbpools}
  //设置初始的数据库连接池数为5个
  for i := 0 to 4 do
    Gob_RmoDBsvr.DBPoolsMM.GetAnPools.Isused := False;
  {$ENDIF}

  AssignCfgFile(GetCurrPath() + 'sys.ini');
end;

procedure Tfrm_main.FormDestroy(Sender: TObject);
begin
//记得养成有借有还的好习惯
  Gob_RmoDBsvr.Free;
  Gio.Free;
end;

end.

