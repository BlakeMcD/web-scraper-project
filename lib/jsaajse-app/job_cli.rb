class JsaajseApp::JobCLI 

    def initialize
        JsaajseApp::Scraper.new.make_jobs_for_multiple_pages
    end

    def start
        system("clear")
        puts "Welcome to JSAAJSE - An app that searches seek.com.au for Australian junior software engineer roles." 
        puts ""
        new_line
        divider
        new_line
        yao_ming
        unique_locations 
        prompt_location_selection

    end

    def list_jobs
        JsaajseApp::Job.all.each.with_index(1) do |job, i|
            puts "#{i}. #{job.job_title}"
        end
    end

    def unique_locations
        JsaajseApp::Job.all.each do |job| 
            unless JsaajseApp::Job.locations.include?(job.location.strip)
                JsaajseApp::Job.locations << job.location
            end  
        end
        JsaajseApp::Job.locations << "Across Australia"
        display_unique_locations(JsaajseApp::Job.locations)
    end

    def display_unique_locations(array)
        array.sort.each.with_index(1) do |element, index|
            puts "#{index}: #{element}"
        end 
    end

    #Formatting functions 
    def new_line
        puts ""
    end

    def divider
        puts "-------------------"
    end

    def contains_letter_or_symbol(str)
        str.match(/[\D]/)
    end

    #prompt user
    def prompt_location_selection

        divider
        puts "select the city you would like to search for:"


        input = gets.strip.to_i

        if input == 0 || input > JsaajseApp::Job.locations.length 
            puts "you done messed up!"
            JsaajseApp::Job.clear_locations
            unique_locations
            prompt_location_selection
        # elsif contains_letter_or_symbol(input)
        #     puts "you put a symbol in here, you peasant!"
        else
            list_jobs_by_location(JsaajseApp::Job.locations.sort[input-1])
        end

        # if contains_letter_or_symbol(input)
        #     puts "you put a symbol in here, you peasant!"
        # else
        #     list_jobs_by_location(JsaajseApp::Job.locations.sort[input])
        # end
    end

    def prompt_return_to_mainscreen
        puts "Input [list] to view the location options"
        puts "Input [exit] to exit the app"

        input = gets.strip.downcase
        if input == "list" 
            unique_locations
            prompt_location_selection
        elsif input == "exit"
            exit
        else
            puts "invalid input!"
            prompt_return_to_mainscreen
        end
    end

    def list_jobs_by_location(city)
        puts "Junior Software Developer Jobs: #{city.upcase}"

        if city == "Across Australia" 
            JsaajseApp::Job.all.map.with_index(1) do |job, i|
                puts "#{i}: #{job.job_title}"
                puts job.location
                puts "#{job.company_name}"
                puts job.statement
        
                puts job.url
        
                divider
                divider
            end
        else
            JsaajseApp::Job.all.map.with_index(1) do |job, i|
                if job.location.include?(city)

                    puts "#{i}: #{job.job_title}"
                    puts job.location
                    puts "#{job.company_name}"
                    puts job.statement

                    puts job.url

                    divider
                    divider
                end
            end
        end
        prompt_return_to_mainscreen
    end
end

def yao_ming
    puts "
                                                                                                                                    
                                                                     _                                                          
                                              |.tbM*fp@@@I8dMJ@O@@@(]@@p.? ~                                                    
                                          ~{fk*@@@@@@@@@@@@@@@@@@@@@@@@@uO@@mv;/                                                
                                       l}XW@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@O@J{va(                                              
                                     bj@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&&*@&OWWLz                                           
                                   ~X@&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*p@WI.                                        
                                 _a@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@k8                                       
                              QkO@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&a?                                      
                              k@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&@J@h_                                    
                          ~Of]@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*@M)                                    
                         }[kO@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&m-                                   
                         Wf*&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@w                                   
                         zJ@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*p                                  
                      ld@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@pJ@f&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@>                                 
                   >ad%@@@@@@@@@@@@@@@@@@@@@@@pp@w@@pMqB@w}/1/w@@@@&&&*@@@@@@@@@@@@@@@@@@@@@@@B                                 
                    u@p@@@@@@@@@@@@@@@@@@@pwX{(|///////?!>> l ,/J&uCO>@@@@@@@@@@@@@@@@@@@@@@@@&(                                
                     (&@@@@@@@@@@@@@@@@@@U?||l;  ~   .         . ~.;~n@@@@@@@@@@@@@@@@@@@@@@@@@@>.                              
                    t% @@@@@@@@@@@J**p*@t?                           L]@@@@@@@@@@@@@@@@@@@@@@@@@1.                              
                    ]@O@@@@@@@d}axII????                             %*@@@@@@@@@@@@@@@@@@@@@@@&@p                               
                    ?@a@*@@*B// |/                                    &@@@@@@@@@@@@@@@@@@@@@@@@@pc                              
                    ?;.a&@@pl                                        a&@@@@@@@@@@@@@@@@@@@@@@@@@@@!                             
                    <)xQ@&*Q)     ,                                  Ma@@@@@@@@@@@@@@@@@@@@@@@@@@Y{                             
                      .[@@@/       ~(uu{>  !1fCr(>~                  ~p@@@@@@@@@@@@@@@@@@@@@@@@@@@I                             
                       QJ&]/   ;rL|  ~nbj}i;,.. ..                    .<m@&@@@@@@@@@@@@@@@@@@a@@@}c                             
                       n@OZ/   n; ){c/<,<tbQL1.                          n&&&@@@@@@@@@@@@@@&&0l)pp>                             
                       )@@/    |/? ]fjI. -<+++                             &&@@@@@@@@@@@@@8I  {v(!,b.                           
                       ,buI     +. ..|_ iW]p&@@@JmX1<                      Y@@@@@@@@@@*@0L< @@@@O@0 v                           
                        ]p|         +_n<af*Ja&@@@@@@@&@@@8L>               .Ua@@@@@@@JXJ]~ t|  ~!jMvl                           
                        ~X|  ;z@@@W.1-(,df/?/U@@pp@@@@@@@@@@@@t              @@@@@&&p/. >)wj),  ?r?t U,                         
                        <U| iMa@@@@?>i . |   ?/??1nYhW@@@@@@@@@Mf{  l.       d@@@@*L>.  >;<?.   .rZ],Z                          
                         u!@]@@p&O}?|/+. l        /////||I!/rf]([|?(.        !@@@@q+      OI   _  1?|Q                          
                         ?k&@&*M/l} u/   ,/                 |l8v t<           jW@&<       j!)/|/I> J!v.                         
                         up@@pZ?    /     |      rfxjx{     J0+,i/|,          ./@*      i !t/    1.C<>                          
                        fa*@@//ctjx?  I   ?[/    Ib@@@@@*@&QUz|;!)xdUv/        _lI      ,(_|_[~| }.v|,                          
                        @&&W?  ///? pr1l  ;f?    *z??////||nv_. ...                      ux.    /+,a_.                          
                        @&w/        //{(~  u| ?  /?     c[l/fqhj[)~                      .f?    ?- 0;                           
                        z8?  rfdWB*n? IuI   l   (f[| rt{<     .                           +{?1z- Lx ~                           
                        ;c| LWu)?IIi+  [.   . u| _>>><|? <.     ~i                        / t   +.  /                           
                         ZI c//     }?L?      .  ) lz|             I                      a&        ).                          
                          xJt/    fvvj(<           . /ft_          .!                     }        f                            
                          Zx|u/zXOr<t ]             _+   I                               <        J                             
                          j !v?  +)  /v            (|ct}( .       i                      !.      @I                             
                          t? /       /.         +/v{. .>C[/l _     !,                     [    Uav                              
                          z/ +.     ?c            .in    >Ct|  ~    <).                   ZO8]!@@                               
                          z/    >/?? ;             <u,   .,/mr    I  i{.                  q}|/ @Y;                              
                          j/    >| {/-     +<>+iI?1jl       | q,     ,Z_                  jl   @|.                              
                          L/ ;  1  n?/  !//(uM@@@8}i        ,|fX- _   ~L,                 i    @<                               
                          d/ /_ul  |]YU/   YUpU/I.           )/x[?n    *                  _?  {h                                
                          fI  //1f? ?rv? fJ[|??             /  ?t]//.  % ~         <     I/   z~                                
                           w/   OI   //  //l<.  (xc1|)|)1vj[? v?/[?t   & [        !     i  r/ Y.                                
                            n/  jI       xfzzf// /I1zfv( ?[|rj rC/ C   d u       /     _/  f/ 0                                 
                            +|  pI     [?/||/I vtr{x{.] ,| !)I(qLM/U   | 1      (     /?   j/ J                                 
                             }l wh/    aqv}    . f  . ~( )jIYa@Ji]IZ  1,>l.    |     |     Z? f                                 
                              tvIju/  @@@|v;? -  , <pa*@**Op&fCI ;/b  k ]-l   ?   !//      t? z                                 
                              i|zlp? z@@(j;      lbppup@qhQkw0/;  |W  M j/_   >  |         [? n                                 
                               c<d(n}/?I0*iInm@@@@Yvvr}]n1i_n?    _* ]] z/    . /          v/ {,                                
                                j]x (n/ /M&@@@@&Zx{>;.,> ]}/?     !n.m +)     I/           c/ Ix                                
                                 >{n1?C? |c@@@> .l lIf(/?| ]      p. U.t!;   /            rI  >B                                
                                  i)cI?L?[!))/?ll ?  /  x+       +} )+ f). ?|             / > -k-                               
                                   ,]c._t/[)       (zr,  .      )n, h.[?. |                 ;  }r.                              
                                     ru  [/    i+;-iII1[x?>     >  <( xl;/           }r?    .  _m                               
                                      c{.xI   c{jfZW@mv1! .    x.  U +/ |            z/   -?,   f                               
                                       v!;j/  ?;  <I!;  .     u   ~h r?/           [c/     /_.  C                               
                                        u;u/ +               !   ?k?[/            x1/ >    /l   >n                              
                                         j/}                   |/{]//            t?  i     +/    p~                             
                                         ? > ,            +  /? Lc|             J?   .      |    Jj                             
                                          d|;/     _    //|//  fc/            {u/  +        i     OL                            
                                          [?/,       i//       j/            t/? .           ~    >]!v.                         
                                          -} /l;   !|         f]I          [C? ~             +     C..z                         
                                           ?LI ?///         Ylwi          x?|                      [_  U>.                      
                                             -tx(       u0( f(/           ;                        -f  .;t                      
                                             )1[ t}?    //  /           .                           }+   .i                     
                                             L//[I? z/                -                             /x+                         
                                           [*/  |t? /                                               <l(                         
                                          !}/    /0i                                                 II                         
                                          M|      Iw/               |_.                              (~                         
                                         q?        !0)            .                                  j                          
                                        Z/          /x/                                              [                          
                                  ~cjv???     >+~-,  /   +  >,                                       -                         "
end