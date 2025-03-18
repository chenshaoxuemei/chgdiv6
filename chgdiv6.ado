capture program drop chgdiv6
program define chgdiv6
	version 14
	syntax [anything(name=divine)]
	
	preserve
	cap use "`c(sysdir_plus)'/c/chgdiv6_iching.dta", clear
	if _rc != 0 {
		di "Downloading IChing……"
		copy "https://gitee.com/chenshaoxuemei/chgdiv6_bkp/raw/master/chgdiv6_iching.dta" "`c(sysdir_plus)'/c/chgdiv6_iching.dta"
		di "Loading completed"
	}
	restore
	
	preserve
	use "`c(sysdir_plus)'/c/chgdiv6_iching.dta", clear
	if missing("`divine'") {
    }
	else {
        capture confirm number `divine'
        if _rc == 0 {
            if divine>10^14{
                di as error "数字太长了."
                exit
            }
			local divine=mod(`divine',2147483647)
			set seed `divine'
        }
        else {
			local maxx=ustrlen("`divine'")
			local number=0
			local numtem=0
			forvalues ixx = 1/`maxx' {
				local sglstr=usubstr("`divine'",`ixx',1)
				local sglstr = tobytes("`sglstr'")
				local max = length("`sglstr'")
				forvalues ix = 1/`max' {
					local char = substr("`sglstr'",`ix', 1)
					if regexm("`char'", "[0-9]") {
						local numtem "`numtem'`char'"
					}
				}
				local number=`number'+`numtem'
				local numtem=0
			}
			if `number'>10^14{
			    di as error "请您精简语言."
				exit
			}
			local divine = mod(`number',2147483647)
			set seed `divine'
        }
    }
	qui di c(current_date)
	qui di c(current_time)
	di in white "日期：今天是" c(current_date) "，现在是" c(current_time)
	qui levelsof words if code == "prepare1",local(pre1)
	qui levelsof words if code == "prepare2",local(pre2)
	di in white `pre1'_n`pre2'
	local tosstime =6
	local chgsum =0
	matrix define divinatory = J(6, 2, .)
	matrix rownames divinatory = "上" "五" "四" "三" "二" "初"
	matrix colnames divinatory = "本" "变"
	while `tosstime'>0{
		local coin1 = int(runiform() + 0.5)
		local coin2 = int(runiform() + 0.5)
		local coin3 = int(runiform() + 0.5)
		local coinsum =`coin1' + `coin2' +`coin3'
		 //step1
		if `coinsum'==3 {
			mat divinatory[`tosstime',1] =1
			mat divinatory[`tosstime',2] =0
			local chgsum =`chgsum'+1
		} //
		else if `coinsum'==2 {
			mat divinatory[`tosstime',1] =0
			mat divinatory[`tosstime',2] =0
		} //
		else if `coinsum'==1 {
			mat divinatory[`tosstime',1] =1
			mat divinatory[`tosstime',2] =1
		} //
		else if `coinsum'==0 {
			mat divinatory[`tosstime',1] =0
			mat divinatory[`tosstime',2] =1
			local chgsum =`chgsum'+1 
		} //
		local tosstime =`tosstime'-1
	}
	
	//step2
		foreach row in 1 2 3 4 5 6{
			local i=el(divinatory,`row',1)
			local div "`div'`i'"
		}
		foreach row in 1 2 3 4 5 6{
			local i=el(divinatory,`row',2)
			local chgdiv "`chgdiv'`i'"
		}
		mat l divinatory
		use "`c(sysdir_plus)'/c/chgdiv6_iching.dta", clear
		qui levelsof words if code =="sym`div'",local(syml)
		qui levelsof words if code =="sym`chgdiv'",local(symr)
		di in white "为" `syml' "之" `symr'";"
	
	//step3
		if `chgsum'==0{
			qui levelsof words if code =="div`div'_0",local(result)
			local result `result'
		}
		else if `chgsum'==1{
			foreach row in 1 2 3 4 5 6{
				if el(divinatory,`row',1) != el(divinatory,`row',2){
					qui levelsof words if code =="div`div'_`row'",local(result)
					local result `result'
				}
			}
		}
		else if `chgsum'==2{
			foreach row in 6 5 4 3 2 1{
				if el(divinatory,`row',1) != el(divinatory,`row',2){
					qui levelsof words if code =="div`div'_`row'",local(aresult)
					local aresult `aresult'
					local result "`aresult'"_n"`result'" 
				}
			}
		}
		else if `chgsum'==3{
			if el(divinatory,6,1) == el(divinatory,6,2){
				qui levelsof words if code == "div`div'_0",local(aresult)
				local aresult `aresult'
				qui levelsof words if code == "div`chgdiv'_0",local(bresult)
				local bresult `bresult'
				local result "`aresult'"_n"`bresult'"
			}
			else if el(divinatory,6,1) != el(divinatory,6,2){
				qui levelsof words if code == "div`chgdiv'_0",local(aresult)
				local aresult `aresult'
				qui levelsof words if code == "div`div'_0",local(bresult)
				local aresult `bresult'
				local result "`aresult'"_n"`bresult'"
			}
		}
		else if `chgsum'==4{
			foreach row in 1 2 3 4 5 6{
				if el(divinatory,`row',1) == el(divinatory,`row',2){
					qui levelsof words if code =="div`chgdiv'_`row'",local(aresult)
					local aresult `aresult'
					local result "`aresult'"_n"`result'" 
				}
			}
		}
		else if `chgsum'==5{
			foreach row in 1 2 3 4 5 6{
				if el(divinatory,`row',1) == el(divinatory,`row',2){
					qui levelsof words if code =="div`chgdiv'_`row'",local(result)
					local result `result'
				}
			}
		}
		else if `chgsum'==6{
			qui levelsof words if code =="div`chgdiv'_0",local(result)
			if "`div'"=="111111"{
				qui levelsof words if code =="div111111_7",local(result)
			}
			else if "`div'"=="000000"{
				qui levelsof words if code =="div000000_7",local(result)
			}
			local result `result'
		}
		qui levelsof words if code =="elaborate",local(elm)
		di in white `elm'
		di in white "`result'"
	restore
	ma drop _all
end