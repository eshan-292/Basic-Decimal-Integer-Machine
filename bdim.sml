
(*    CODE STARTS HERE      *)

(* The main function which includes all the code and takes in the file name as the only parameter *)
fun interpret (fname) =
    let 
        val mem = Array.array(100000, 0)        (* memory array *)
            (* This is a function which prompts the user to input a number *)
            fun getNumber() = 
            let
                val x = print ("INPUT \n")
                val str = valOf (TextIO.inputLine TextIO.stdIn)
                val i : int = valOf (Int.fromString str)
            in
                i
            end ;

        (* This is a function which reads the text from the file as a string and then breaks it down into a list of strings based on the separation with comma *)
        fun linelist file =
            let val instr = TextIO.openIn file
                val str   = TextIO.inputAll instr
            in String.tokens Char.isPunct str
            before
            TextIO.closeIn instr
            end;
        
        val x = linelist(fname)     
        
        (* This is a function which breaks a list of string into a quadruple(tuple of size 4) *)
        fun convertsingle (a) =
        let
            val i1 : int = valOf (Int.fromString (List.nth(a,0))) 
            val i2 : int = valOf (Int.fromString (List.nth(a,1))) 
            val i3 : int = valOf (Int.fromString (List.nth(a,2))) 
            val i4 : int = valOf (Int.fromString (List.nth(a,3)))
            in (i1,i2,i3,i4)  end;

        (* This is a function which splits a list of strings into a list of quadruples *)
        fun split (a,ans) =  
            if null a then ans
            else 
            let val b = List.take(a,4)
            val c = List.drop(a,5)
            in split(c,convertsingle(b)::ans) end ;;
        
        val revans = split(x,[]) ;
        val code = rev revans ;     (* Reversing the list as the obtained list is in reverse order as per the implementation in split function *)
        val newcode = code ;

        (* This is a function which performs the or operation on two integers *)
        fun or2 (x,y) = 
        if x=1 orelse y=1 then 1
        else 0 ;

        (* This is a function which performs the and operation on two integers *)
        fun and2 (x,y) = 
        if (x=0 orelse y=0) then 0
        else 1 ;

        (* These functions return the ith element of a tuple (i=1,2,3,4) *)
        fun first (x, _, _, _) = x ;
        fun second (_, x, _, _) = x ;
        fun third (_, _, x, _) = x ;
        fun fourth (_, _, _, x) = x ;

        (* This is the function which recurses over the code line by line (quadruple by quadruple)*)
        fun sol (newcode) = 
        if null newcode then print("End") 
        else 
        let 
            val c = List.hd newcode 
            val v1= first c
            val v2= second c
            val v3= third c
            val v4= fourth c
            
            (* This works as per the rules of opcodes *)
            val x = if v1=0 then print("PROGRAM TERMINATED \n")
                    else if v1=1 then 
                                let 
                                    val y = getNumber() 
                                    val z = Array.update(mem, v4, y)
                                in sol(List.drop(newcode,1)) 
                                end 
                        else if v1=2 then let val x =Array.update(mem, v4, Array.sub(mem, v2)) in sol(List.drop(newcode,1)) end
                                else if v1=3 then 
                                            let val a =  Array.sub(mem, v2)
                                                val b = if a=1 then 0 else 1 
                                                val c = Array.update(mem, v4, b)
                                            in sol(List.drop(newcode,1)) end
                                    else if v1=4 then let val x = Array.update(mem, v4, or2(Array.sub(mem, v2), Array.sub(mem, v3))) in sol(List.drop(newcode,1)) end
                                            else if v1=5 then let val x = Array.update(mem, v4, and2(Array.sub(mem, v2), Array.sub(mem, v3))) in sol(List.drop(newcode,1)) end
                                                else if v1=6 then let val x = Array.update(mem, v4, Array.sub(mem, v2)+Array.sub(mem, v3)) in sol(List.drop(newcode,1)) end
                                                    else if v1=7 then let val x = Array.update(mem, v4, Array.sub(mem, v2)-Array.sub(mem, v3)) in sol(List.drop(newcode,1)) end
                                                            else if v1=8 then let val x =Array.update(mem, v4, Array.sub(mem, v2)*Array.sub(mem, v3)) in sol(List.drop(newcode,1)) end
                                                                else if v1=9 then let val x = if Array.sub(mem, v3)=0 then print("DIVISION BY ZERO NOT ALLOWED")    
                                                                                                else  Array.update(mem, v4, Array.sub(mem, v2) div Array.sub(mem, v3)) in sol(List.drop(newcode,1)) end
                                                                        else if v1=10 then let val x = if Array.sub(mem, v3)=0 then print("MODULO BY ZERO NOT ALLOWED") 
                                                                                                        else  Array.update(mem, v4, Array.sub(mem, v2) mod Array.sub(mem, v3)) in sol(List.drop(newcode,1)) end
                                                                            else if v1=11 then let val x = Array.update(mem, v4, if Array.sub(mem, v2)=Array.sub(mem, v3) then 1 else 0) in sol(List.drop(newcode,1)) end
                                                                                    else if v1=12 then let val x = Array.update(mem, v4, if Array.sub(mem, v2)>Array.sub(mem, v3) then 1 else 0) in sol(List.drop(newcode,1)) end
                                                                                        else if v1=13 then if (Array.sub(mem, v2)=1) then (sol(List.drop(code, v4))) else sol(List.drop(newcode,1))
                                                                                                else if v1=14 then sol(List.drop(code, v4))
                                                                                                    else if v1=15 then let val x = print(Int.toString(Array.sub(mem, v2))^"\n") in sol(List.drop(newcode,1)) end
                                                                                                            else if v1=16 then let val x = Array.update(mem, v4, v2) in sol(List.drop(newcode,1)) end
                                                                                                                else let val x = print("") in sol(List.drop(newcode,1)) end
                                                                    

        in ()  end ; ;

        val e = sol(code) ;
    in () end ; ;

(* interpret(); *)