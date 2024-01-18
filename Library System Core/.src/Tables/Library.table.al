table 50700 Library
{
    Caption = 'Library';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(10; "Book ID"; Integer)
        {
            AutoIncrement = true;
            Caption = '';
        }
        field(20; "Title"; Text[50])
        {
            Caption = '';
            NotBlank = true;   
        }
        field(30; "Author"; Text[50])
        {
            Caption = '';
            NotBlank = true;   
        }
        field(40; "Rented"; Boolean)
        {
            Caption = '';
            ObsoleteState = Removed;
        }
         field(120; "Series"; Integer)
        {
            TableRelation = BookSeries."Series ID";
            Caption = '';
            NotBlank = true;   
        }
        field(50; "Genre"; Text[50])
        {
            Caption = '';
            NotBlank = true;   
        }
        field(60; "Publisher"; Text[50])
        {
            Caption = '';
            NotBlank = true;   
        }
        field(70; "Book Price"; Text[50])
        {
            Caption = '';
            NotBlank = true;   
        }
        field(80; "Publication Date"; Date)
        {
            Caption = '';
            NotBlank = true;   
        }
        field(90; "Pages"; Integer)
        {
            Caption = '';
            NotBlank = true;   
        }
        field(150; "Prequel"; Text[50])
        {
            Caption = '';
            NotBlank = true;   
        }
        field(160; "Sequel"; Text[50])
        {
            Caption = '';
            NotBlank = true;   
        }
        field(100; "Prequel ID"; Integer)
        {
            Caption = '';
            NotBlank = true;   
        }
        field(110; "Sequel ID"; Integer)
        {
            Caption = '';
            NotBlank = true;   
        }
       
        field(140; "Rented Count"; Integer)
        {
            Caption = '';
            NotBlank = true;   
        }
       
        field(170; "Edit Sequel"; Boolean)
        {
            Caption = '';
            NotBlank = true;   
        }

        field(180; "Status"; Enum Status)
        {
            Caption = '';
            NotBlank = true;   
        }
        field(190; "Grade"; Enum Grades)
        {
            Caption = '';
            NotBlank = true;   
        }
        field(200; "Grading Justification"; Text[1000])
        {
            Caption = '';
            NotBlank = true;  
        }
    }
    keys
    {
        key(PK; "Book ID")
        {
            Clustered = true;
        }
        // key(FK; "Series")
        // {
        //    Unique = true; 
        // }
    }
    procedure AddBookSequel()
    var
        newRecord: Record Library;
        newRentedBook: Page BookSpecifications;
    begin
        newRecord.Init();
        newRecord.Author := Rec.Author;
        newRecord.Series := Rec.Series;
        newRecord.Genre := Rec.Genre;
        newRecord.Publisher := Rec.Publisher;
        newRecord.Publisher := Rec.Publisher;
        newRecord.Prequel := Rec.Title;
        newRecord."Prequel ID" := Rec."Book ID";
        newRecord."Edit Sequel" := true;
        newRecord.Insert();
     
        newRentedBook.SetRecord(newRecord);
        newRentedBook.Run();
    end;

    procedure OpenLibraryPage()
    var
        Library: Page LibraryBookList;
    begin
        Library.Editable(false);
        Library.Run();
    end;

    procedure UpdatePrequelSequel()
    var
        libraryBooks: Record Library;
    begin
       if(Rec."Edit Sequel" = true) then
        begin
        libraryBooks.SetFilter("Book ID", '=%1', Rec."Prequel ID");
        libraryBooks.FindFirst();
        libraryBooks.Sequel := Rec.Title;
        libraryBooks."Sequel ID" := Rec."Book ID";
        libraryBooks.Modify();
        end;
    end;
    procedure LastTwoYearsFilter()
    var
        Today: Date;
        TwoYearsAgo: Date;
        NewField: Text[50];
        Library: Record Library;
    begin
        Today := WorkDate();
        TwoYearsAgo := Today - 730;
        Rec.SetFilter("Publication Date", '>%1',TwoYearsAgo);
    end;

    // procedure StatusReceivingRepair()
    // var
    //     Library: Record Library;
    // begin
    //     //  if Rec.Status.Value() = 'Out for repair' then
    //     // begin
    //     //             //popupMessage := popupMessage + bookName.Get(i);
    //     // end;
    // end;
    
    procedure RentBook() : Record RentedBooks
    var
        
        simpleText: Text[50];
        newRecord: Record RentedBooks;
        newRentedBook: Page RentBook;
    begin
        simpleText := Rec.Title;
        // Rec."Book Name" := record.Title;
        newRecord.Init();
        newRecord."Book Name" := simpleText;
        newRecord."Book ID" := Rec."Book ID";
        newRecord."Date Rented" := System.Today();
        newRecord.Status := Rec.Status;
        newRecord.Insert();
        //RentedBook1 := newRecord;
        // newRecord.setContext();
        //Message(simpleText); 
        newRentedBook.SetRecord(newRecord);
        newRentedBook.Run();
        //."Book Name" := simpleText;  
       // Rec."Rent ID" := xRec."Rent ID";
        exit(newRecord); 
    end;
    
    // procedure OpenRentingPage(record: Record Library) : Record Library
    // var
    //     simpleText: Text[50];
    // begin
    //     simpleText := record.Title;
    //     Message(simpleText);
        
    // end;
}