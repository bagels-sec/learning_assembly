#include <stdio.h>
#include <string.h>

extern int rarea(int, int);
extern int rcircum(int, int);
extern double carea( double);
extern double ccircum( double);
extern void sreverse(char *, int);
extern void adouble(double [], int );
extern double asum(double [], int );

int main (){

	char rstring[64];
	int side1, side2, r_area, r_circum;
	double radius, c_area, c_circum;

	double darray[] = {70.0, 83.2, 91.5, 72.1, 55.5};
	long int len;
	double sum;

	//call asm function with int arguments
	printf("Compute area and circuference of a rectangle\n");
	printf("Enter length of one side: \n");
	scanf("%d", &side1);
	printf("Enter length of other side: \n");
	scanf("%d", &side2);
	r_area = rarea(side1, side2);
	r_circum = rcircum(side1, side2);
	printf("The area of the rectangle = %d\n\n", r_circum);
	

	//call asm function with double argument
	printf("Computer area and circumference of a circle\n");
	printf("Enter radius: \n");
	scanf("%lf", &radius);
	c_area = carea(radius);
	c_circum = ccircum(radius);
	printf("The Circumference of the circle = %lf\n\n", c_circum);

	//call asm function with string argument
	printf("reverse a string\n");
	printf("Enter the string: \n");
	scanf("%s", rstring);
	printf("The reverse string is = %s\n\n", rstring);

	//call asm function with array argument
	len = sizeof (darray) / sizeof (double);
	printf("The array has %lu elements", len);
	printf("The elements of the array are: \n");
		for (int i = 0; i<len;i++){
			printf("Element %d = %lf\n", i, darray[i]);
		}
	sum = asum(darray,len);
	printf("The sum of the elements of this array = %lf\n", sum);

	return 0;
}
