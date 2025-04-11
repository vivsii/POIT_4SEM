package by.belstu.by.Evseenko.basejava;

import static java.lang.Math.*;

/*
@author Evseenko Vika
@version 1.0
 */


public class JavaTest {
            static int sint;
            final int const3 = 5;
            public final int const1 = 10;
            public static final int const2 = 15;


            public static void main(String[] args) {

                char sym = 'a';
                int num = 120;
                short shNum = 1513;
                String str = "hello";
                byte bNum = 4;
                long lNum = -3314124;
                boolean bool = true;
                double dNum = 5.13;

                String resultStrAndNum = str + num;
                System.out.println(resultStrAndNum);

                String resultStrAndSym = str + sym;
                System.out.println(resultStrAndSym);

                String resultStrAndDouble = str + dNum;
                System.out.println(resultStrAndDouble);

                byte newByte = (byte) (bNum + num);
                System.out.println(newByte);

                int newInt = (int) dNum + (int) lNum;
                System.out.println(newInt);

                long newL = (long) num + (long) 2147483647;
                System.out.println(newL);

                System.out.println(sint);



                System.out.println(true ^ false);

                System.out.println(true && false);

                var var1 = 9223372036854775807L;
                var var2 = 0x7fff_ffff_fffL;

                char s1 = 'a';
                char s2 = '\u0061';
                char s3 = 97;

                System.out.println(s1 + s2 + s3);

                System.out.println(3.45 % 2.4);
                System.out.println(1.0 / 0.0); //INF
                System.out.println(0.0 / 0.0);//NaN
                System.out.println(Math.log(-345));//NaN
                System.out.println(Float.intBitsToFloat(0x7F800000));//INF
                System.out.println(Float.intBitsToFloat(0xFF800000));//-INF


                var Pi = Math.PI;
                var E = Math.E;
                System.out.println(PI);
                System.out.println(E);
                System.out.println(Math.round(Pi));
                System.out.println(Math.round(E));
                System.out.println(Math.min(Pi, E));
                System.out.println(Math.random());

                Boolean b = false;
                Character c = 'c';
                Integer i = 20;
                Byte b1 = 40;
                Short s = 314;
                Long l = 3131414L;
                Double d = 13.15;

                System.out.println(c >> 2);
                System.out.println(c << 2);
                System.out.println(l * 0.1);
                System.out.println(b && true);
                System.out.println(c + i);

                System.out.println(Long.MAX_VALUE);
                System.out.println(Long.MIN_VALUE);
                System.out.println(Double.MAX_VALUE);
                System.out.println(Double.MIN_VALUE);

                int NewInt = 27;
                Integer o = NewInt;
                System.out.println(o);
                NewInt = o;


                byte NewByte = 30;
                Byte k = NewByte;
                System.out.println(k);
                NewByte = k;

                System.out.println(Integer.parseInt("12"));
                System.out.println(Integer.toHexString(134));
                System.out.println(Integer.compare(13, 26));
                System.out.println(Integer.toString(31));
                System.out.println(Integer.bitCount(12));
                System.out.println(Double.isNaN(NewInt));

                String stroke = "2345";

                var i2 = Integer.parseInt(stroke);
                var i3 = Integer.valueOf(stroke);

                byte[] bytes = stroke.getBytes();
                String st = new String(bytes);
                System.out.println(st);

                String strAsBool = "true";
                Boolean newBool = Boolean.parseBoolean(strAsBool);
                Boolean newBool3 = Boolean.valueOf(strAsBool);

                String strokeComp1 = "This is stroke";
                String strokeComp2 = "This is stroke";
                System.out.println(strokeComp1.equals(strokeComp2));
                System.out.println(strokeComp1.compareTo(strokeComp2));
                System.out.println(strokeComp1 == strokeComp2);



                System.out.println('\n' + str.hashCode());
                System.out.println(str.indexOf('l'));
                System.out.println(str.length());
                System.out.println(str.replace('e', 'u'));

                char[][] c1;
                char[] c2[];
                char c3[][];

                c1 = new char[3][];
                c1[0] = new char[1];
                c1[1] = new char[2];
                c1[2] = new char[3];
                System.out.println(c1.length);
                System.out.println(c1[0].length);
                System.out.println(c1[1].length);
                System.out.println(c1[2].length);

                c2 = new char[][]{{'a', 'b'}, {'c', 'd'}};
                c3 = new char[][]{{'b', 'c'}, {'s', 'e'}};
                System.out.println(c2 == c3);
                c2 = c3;
                System.out.println(c2 == c3);

                System.out.println('\n');
                for (var it : c2
                ) {
                    System.out.println(it);
                }



                WrapperString testWrapp = new WrapperString("chelsea") {
                    @Override
                    public String replaces(char oldchar, char newchar) {
                        this.str = this.str.replace(oldchar, newchar);
                        System.out.println("Method replaces");
                        return str;
                    }

                    ;

                    @Override
                    public String deletes(char newchar) {
                        this.str = this.str.replace(newchar, "".toCharArray()[0]);
                        System.out.println("Method deletes");
                        return str;
                    }

                    ;
                };

                String test2 = "";
                test2 = testWrapp.replaces('e', 'p');
                System.out.println(test2);
            }
        }