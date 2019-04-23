package org.lab409.entity;

import lombok.Data;

@Data
public class SemesterAndYear
{
    private String semester;
    private Integer year;
    public SemesterAndYear(String semester,Integer year)
    {
        this.semester=semester;
        this.year=year;
    }
    @Override
    public int hashCode()
    {
        return (semester+year).hashCode();
    }
    @Override
    public boolean equals(Object obj)
    {
        if (obj instanceof SemesterAndYear) {
            SemesterAndYear sem= (SemesterAndYear) obj;
            return this.semester.equals(sem.semester)&&this.year.equals(sem.year);
        }
        return false;
    }
}
