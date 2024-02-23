class Date
{
public:
    Date();
    Date(int year,int month,int day);
    int getYear();
    void setYear(int year);
    int getMonth();
    int getDay();
    void setMonth(int month);
    void setDay(int day);
    void Print();

private:
    int year;
    int month;
    int day;
};

class Student
{
public:
    Student(int id, int year, int month, int day);
    ~Student();
    int getId();
    Date* getBirthDate() const;
    static int getNumberOfObjects(); //return the number of Student objects 
 
private:
    int id;
    Date* birthDate; 
    static int numberOfObjects; //count the number of Student objects
};