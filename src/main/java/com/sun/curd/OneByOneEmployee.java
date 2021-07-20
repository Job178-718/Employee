package com.sun.curd;

import java.util.List;

public class OneByOneEmployee<T> {
    public  void  OneByOnePrintln(List<T> t){
        for(T e:t){
            System.out.println(e);
        }
    }
}
