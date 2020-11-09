#include <cstdio>
#include <cstring>

struct Student {
	int age;
	char name[30];
};

//typedef struct Student student_t;

void Student_print(const struct Student *x)
{
	printf("I'am a %s of %d years old!\n", x->name, x->age);
}

int main()
{
	struct Student a;
	a.age = 18;
	strcpy(a.name, "John"); 
	
	Student_print(&a);

	return 0;
}

