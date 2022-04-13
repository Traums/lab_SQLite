//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Unit2.h"

#include <string>
#include <string.h>
#include "sqlite3.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "VirtualTrees"
#pragma resource "*.dfm"
TForm2 *Form2;

char* intToStr(int data);
//---------------------------------------------------------------------------
__fastcall TForm2::TForm2(TComponent* Owner)
	: TForm(Owner)
{
	VirtualStringTree1->NodeDataSize = sizeof(TreeNodeStruct);
}
//---------------------------------------------------------------------------
void __fastcall TForm2::Button1Click(TObject *Sender)
{

	VirtualStringTree1->Clear();
	sqlite3* DataBase;

	//Открытие БД
	int openResult = sqlite3_open16(L"..\\..\\DB\\Databases.db", &DataBase);
	const char *errmsg;
	sqlite3_stmt *pStatement;

	//Подготовка запроса
	int result = sqlite3_prepare16_v2(DataBase, L"Select * FROM conversations ORDER BY id ASC", -1, &pStatement, NULL);

	if( result != SQLITE_OK)
	{
		errmsg = sqlite3_errmsg(DataBase);
	}
	else
	{
		errmsg = "DONE";
	};

	//Выполнение запроса
	for (int  i = 0;;i++)
	{
		result = sqlite3_step(pStatement);
		if(result == SQLITE_DONE)
			break;

		PVirtualNode entryNode = VirtualStringTree1->AddChild(VirtualStringTree1->RootNode);
		TreeNodeStruct *nodeData = (TreeNodeStruct*)VirtualStringTree1->GetNodeData(entryNode);

		unsigned int val = sqlite3_column_int(pStatement,0);
		nodeData->Id = val;

		wchar_t *wstr = (wchar_t*)sqlite3_column_text16(pStatement,3);
		nodeData->Type = wstr;

		wstr = (wchar_t*)sqlite3_column_text16(pStatement,4);
		nodeData->Message = wstr;

		wstr = (wchar_t*)sqlite3_column_text16(pStatement,5);
		nodeData->Name = wstr;

		wstr = (wchar_t*)sqlite3_column_text16(pStatement,6);
		nodeData->ProfileName = wstr;

		wstr = (wchar_t*)sqlite3_column_text16(pStatement,9);
		nodeData->Phone = wstr;

		val = sqlite3_column_int(pStatement,12);
		nodeData->ProfileID = val;

	};

	sqlite3_finalize(pStatement);

	sqlite3_close(DataBase);

	/*
	int Id;
	UnicodeString Type;
	UnicodeString Message;
	UnicodeString Phone;
	UnicodeString Name;
	UnicodeString ProfileName;
	int ProfileID;
	*/

}
//---------------------------------------------------------------------------
void __fastcall TForm2::VirtualStringTree1GetText(TBaseVirtualTree *Sender, PVirtualNode Node,
          TColumnIndex Column, TVSTTextType TextType, UnicodeString &CellText)

{
	if(!Node)return;
	TreeNodeStruct *nodeData = (TreeNodeStruct*)VirtualStringTree1->GetNodeData(Node);
	switch(Column)
	{
		case 0:
		{
			CellText = UnicodeString(nodeData->Id); break;
		}
		case 1:
		{
			CellText = UnicodeString(nodeData->Type); break;
		}
		case 2:
		{
			CellText = UnicodeString(nodeData->Name); break;
		}
		case 3:
		{
			CellText = UnicodeString(nodeData->ProfileName); break;
		}
		case 4:
		{
			CellText = UnicodeString(nodeData->Phone); break;
		}
	};
}
//---------------------------------------------------------------------------
void __fastcall TForm2::VirtualStringTree1AddToSelection(TBaseVirtualTree *Sender,
          PVirtualNode Node)
{
	TreeNodeStruct *nodeData = (TreeNodeStruct*)VirtualStringTree1->GetNodeData(Node);

	PVirtualNode selectedNode = VirtualStringTree1->FocusedNode;
	unsigned int selectedNodeIndex = selectedNode->Index;


	Edit1->Text = nodeData->Type;
	Edit2->Text = nodeData->ProfileID;
}
//---------------------------------------------------------------------------
void __fastcall TForm2::Button2Click(TObject *Sender)
{
    VirtualStringTree1->Clear();
}
//---------------------------------------------------------------------------
void __fastcall TForm2::Button3Click(TObject *Sender)
{
	PVirtualNode selectedNode = VirtualStringTree1->FocusedNode;
	VirtualStringTree1->DeleteNode(selectedNode);

	int selectedNodeIndex = selectedNode->Index;
	int delIndex;
	sqlite3* DataBase;
	sqlite3_stmt *pStatement;
	const char *errmsg;
	int openResult = sqlite3_open16(L"..\\..\\DB\\Databases.db", &DataBase);
	char *sqlStr;

	selectedNodeIndex = selectedNodeIndex + 1;
	char *buf = intToStr(selectedNodeIndex);

	sqlStr = "DELETE FROM conversations WHERE id = ";
	char *res = strcat(sqlStr,buf);
	int deleteRes =  sqlite3_exec(DataBase, res,NULL, NULL ,NULL);

	sqlite3_close(DataBase);
}
//---------------------------------------------------------------------------
char* intToStr(int data) {
    std::string strData = std::to_string(data);

    char* temp = new char[strData.length() + 1];
    strcpy(temp, strData.c_str());

   return temp;
}