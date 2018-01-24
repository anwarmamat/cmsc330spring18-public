class Functions
    def double(n) 
        n * 2
    end

    def half(n)
        n / 2
    end

    def f(s) 
        r = ""
        for i in (0..(s.length-1)) do
            r << (s[i].ord + 1).chr
        end

        r
    end
end
