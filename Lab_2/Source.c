// ������ ��������� ��������� ���-�������, � ����� ��������� ������� ����������, ��������, ������������ ������� � ���� �������
// ����� ��������, ��� ��� ������� ����� ����������� ���� ������� ����� �� ���������� capacity (�����������)
// �� ���� ���������� ����� �������� ������ ���-�������
// ��� ������ ����� ��������� �������� ��������� ������� � ������� _CRT_SECURE_NO_WARNINGS
// ��� ���������� ��� ���������� ������ ��������� �������, ���������� ����� ������ 2013-2014 ���� ����������
#define _CRT_SECURE_NO_WARNINGS

#include <stdio.h>
#include <stdlib.h>

// ������ ��������� ���������� ��� �������� ��������� 1-�� �������� ���-�������
struct el
{
    int key;                        // ���� �������� ���-�������
    int data;                       // ������ �������� ���-�������
};

struct el* array;
int capacity = 10;                  // �� ����� ������ �������, ��������� �������� ������ ��������� �������
int size = 0;

// ������� ���������� ���-������� ���� ������ ������� �� ������� ����� �� ���������� capacity
int hashFunction(int key)
{
    return (key % capacity);
}

int checkPrime(int n)
{
    int i;
    if (n == 1 || n == 0)
    {
        return 0;
    }
    for (i = 2; i < n / 2; i++)
    {
        if (n % i == 0)
        {
            return 0;
        }
    }
    return 1;
}
int getPrime(int n)
{
    if (n % 2 == 0)
    {
        n++;
    }
    while (!checkPrime(n))
    {
        n += 2;
    }
    return n;
}
void init_array()
{
    capacity = getPrime(capacity);
    array = (struct el*)malloc(capacity * sizeof(struct el));
    for (int i = 0; i < capacity; i++)
    {
        array[i].key = 0;
        array[i].data = 0;
    }
}

// ������� ���������� ������ �������� � ���-�������
void insert(int key, int data)
{
    int index = hashFunction(key);
    if (array[index].data == 0)
    {
        array[index].key = key;
        array[index].data = data;
        size++;
        printf("\n Key (%d) is insered \n", key);
    }
    else if (array[index].key == key)
    {
        array[index].data = data;
    }
    else
    {
        printf("\n There was a collision \n");
    }
}
// ������� �������� �������� �� �������
void remove_element(int key)
{
    int index = hashFunction(key);
    if (array[index].data == 0)
    {
        printf("\n This key does not exist \n");
    }
    else
    {
        array[index].key = 0;
        array[index].data = 0;
        size--;
        printf("\n Key (%d) has been deleted \n", key);
    }
}
// ������� ����������� ���-�������
void display()
{
    int i;
    for (i = 0; i < capacity; i++)
    {
        if (array[i].data == 0)
        {
            printf("\n data[%d]: empty ", i);
        }
        else
        {
            printf("\n Key: %d data[%d]: %d \t", array[i].key, i, array[i].data);
        }
    }
}

// ������� ������������ ������� ���-�������
int size_of_hashtable()
{
    return size;
}

// ������ �������� ���������
int main()
{
    int choice, key, data, n;
    int c = 0;
    init_array();

    do
    {
        printf("Welcome to the hash table mateser!"
            "\n1.Insert a new element into the hash table"
            "\n2.Remove an element from the hash table"
            "\n3.Find the hash table size"
            "\n4.Display a hash table"
            "\n\nSelect the desired item: ");

        scanf("%d", &choice);
        switch (choice)
        {
        // ���������� ���������� �����
        case 1:

            printf("Enter the key:\t");
            scanf("%d", &key);
            printf("Enter the data:\t");
            scanf("%d", &data);
            insert(key, data);

            break;

        // ���������� �������� ���-�������
        case 2:

            printf("Enter the key to be deleted:");
            scanf("%d", &key);
            remove_element(key);

            break;
        
        // ���������� ������ ������� ���-�������
        case 3:

            n = size_of_hashtable();
            printf("Hash Table size is: %d\n", n);

            break;
        // ���������� ����������� ���-�������
        case 4:

            display();

            break;
        
        // ��������� ����� ���������, ���� ����� ����� ������, �� ���������� ����
        default:

            printf("Wrong data\n");
        }

        printf("\nDo you want to continue? (Press 1, if you agree): ");
        scanf("%d", &c);

    } while (c == 1);
}
