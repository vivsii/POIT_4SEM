package by.belstu.by.Evseenko.basejava;

import java.util.Objects;

/*
@author Evseenko Vika
@version 1.1
 */
public class WrapperString {

//@see #str
    String str;

    public WrapperString(String str) {
        this.str = str;
    }

    public String getstr() {
        return str;
    }


    public void setstr(String str) {
        this.str = str;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        WrapperString that = (WrapperString) o;
        return Objects.equals(str, that.str);
    }

//    @return str

    @Override
    public int hashCode() {
        return Objects.hash(str);
    }

    @Override
    public String toString() {
        return "WrapperString{" +
                "str='" + str + '\'' +
                '}';
    }


/*      @param oldchar - старый символ
      @param newchar - новый символ
     */

    public String replaces(char oldchar, char newchar) {
        return str;
    }

    ;

    public String deletes(char newchar) {
        return str;
    }

    ;
}