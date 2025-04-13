/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.learn.mycart.helper;

/**
 *
 * @author Dipak Kale
 */
public class Helper {
    
    public static String get10Words(String desc) // Fix: Changed 'Static' to 'static'
    {
        String[] strs = desc.split(" "); // Fix: Corrected split to use space (" ") instead of an empty string

        if (strs.length > 10) // Fix: Corrected 'lenght' to 'length'
        {
            String res = "";
            for (int i = 0; i < 10; i++) // Fix: Changed 'for(int i=0<i<10;i++)' to proper loop syntax
            {
                res = res + strs[i] + " "; // Fix: Added space to separate words
            }

            return res.trim() + "..."; // Fix: Used trim() to remove trailing space
        } 
        else 
        {
            return desc + "...";
        }
    }
}
