type array = {
    id: number,
    name: string,
    group: number
}
const array: Array<array> = [
    {id: 1, name: 'Vasya', group: 10}, 
    {id: 2, name: 'Ivan', group: 11},
    {id: 3, name: 'Masha', group: 12},
    {id: 4, name: 'Petya', group: 10},
    {id: 5, name: 'Kira', group: 11},
]
//==========
class CarsType{
    manufacturer?: string
    model?: string
}

type ArrayCarsType = {
    cars:CarsType[]
}
let car: CarsType = {}; //объект создан!
car.manufacturer = "manufacturer";
car.model = 'model';

const car1: CarsType = {}; //объект создан!
car1.manufacturer = "manufacturer";
car1.model = 'model';

const car2: CarsType = {}; //объект создан!
car2.manufacturer = "manufacturer";
car2.model = 'model';

const arrayCars: Array<ArrayCarsType> = [{
    cars: [car1, car2]
}];
 //=================
type MarkFilterType = 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10
type DoneType = boolean
type MarkType = {
    subject: string,
    mark: MarkFilterType, // может принимать значения от 1 до 10
    done: DoneType,
}
type GroupFilterType = 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 | 11 | 12
type StudentType = {
    id: number,
    name: string,
    group: GroupFilterType, // может принимать значения от 1 до 12
    marks: Array<MarkType>,
}

type GroupType = {
    students: Array<StudentType> // массив студентов типа StudentType
    studentsFilter: (group: GroupFilterType) => Array<StudentType>, // фильтр по группе
    marksFilter: (mark: MarkFilterType) => Array<StudentType>, // фильтр по  оценке
    deleteStudent: (id: number) => void, // удалить студента по id из  исходного массива
}
let mark1: MarkType = { subject: "JS", mark: 10, done: true}

let mark2: MarkType = { subject: "JAVA", mark: 5, done: true}

let mark3: MarkType = { subject: "OAiP", mark: 5, done: true}

let student1: StudentType = { id: 1, name: "Vadim", group: 6, marks: [mark1, mark2, mark3]}

let student2: StudentType = { id: 2, name: "Vika", group: 4, marks: [mark1, mark2]}

let student3: StudentType = { id: 3, name: "Dasha", group: 9, marks: [mark2, mark3]}

const GROUP: GroupType = {

    students: [student1, student2, student3],

    studentsFilter(group: GroupFilterType): StudentType[] 
    {
        const filteredStudents: Array<StudentType> = [];

        for (let student of this.students) 
        {
            if (student.group == group) 
            {
                filteredStudents.push(student);
            }
        }
        return filteredStudents;
   },
    marksFilter(mark: MarkFilterType): StudentType[]
    {
        const filteredStudents: Array<StudentType> = [];

        for (let student of this.students) 
        {
            for(let mark_ of student.marks) {

            if (mark_.mark == mark) 
            {
                filteredStudents.push(student);
            }
        }

        }
        return filteredStudents;
    },

    deleteStudent(id: number): void 
    {
      this.students = this.students.filter((student) => student.id !== id);
    },
  };
console.log(GROUP.studentsFilter(4));
for (let a of GROUP.marksFilter(5)){console.log(a)};
GROUP.deleteStudent(2);
for(let a of GROUP.students)
{
    console.log(a);
}
