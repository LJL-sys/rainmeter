function Initialize()
	SeO='!SetOption'
	Lnumf()
	Mode()
	LineGet()
	K=0
	Band = {} for i = 1,Lnum do Band[i]=0 end
	BandV = 0
	SKIN:Bang("!ActivateConfig", "#ROOTCONFIG#\\time")
	MoveTime()
	for i = Lnum+1,90 do 
		SKIN:Bang(SeO, 'Line'..i, 'Hidden' ,'1')
		SKIN:Bang(SeO, 'LineC'..i, 'Hidden' ,'1')
	end
end

function Update()
	MoveTime()
	BandValue()
	Line()
end

function BandValue( ... )
	for i = 1,Lnum do
		Band[i]=(SKIN:GetMeasure('Band'..i)):GetValue()
	end
end

function Line( ... )
		K= K+1
		Kl = math.pi/3000*math.fmod(K,3000)*2
		if K == 3000 then K = 0 end
		for i = 1,Lnum do

			SKIN:Bang(SeO, 'Line'..i, 'MeterStyle' ,'LineStyle')
			SKIN:Bang(SeO, 'Line'..i, 'StartAngle' ,(math.pi/Lnum*(i-1)*2-Kl))
			SKIN:Bang(SeO, 'Line'..i, 'LineWidth' ,OuterWidth)
			SKIN:Bang(SeO, 'Line'..i, 'LineColor' ,'#Color#,'..(Band[i]*250))

			SKIN:Bang(SeO, 'LineC'..i, 'LineWidth' ,InnerWidth)
			SKIN:Bang(SeO, 'LineC'..i, 'MeterStyle' ,'LineStyle')
			SKIN:Bang(SeO, 'LineC'..i, 'StartAngle' ,(math.pi/Lnum*(i-1)*2+Kl))
			SKIN:Bang(SeO, 'LineC'..i, 'LineStart' ,(125-InnerLength-Band[i]*30))
			SKIN:Bang(SeO, 'LineC'..i, 'LineLength' ,'131')
			SKIN:Bang(SeO, 'LineC'..i, 'LineColor' ,'#Color#,'..(40+Band[i]*213))

			if mode == 1 then
				SKIN:Bang(SeO, 'Line'..i, 'LineStart' ,(130+Band[i]*110+OuterLength))
				SKIN:Bang(SeO, 'Line'..i, 'LineLength' ,(134+Band[i]*110+OuterLength))							
			elseif mode == 2 then
				SKIN:Bang(SeO, 'Line'..i, 'LineStart' ,(110+Band[i]*110+Band[i]*40))
				SKIN:Bang(SeO, 'Line'..i, 'LineLength' ,(150+Band[i]*110-Band[i]*5))
				SKIN:Bang(SeO, 'Line'..i, 'LineWidth' ,Band[i]*5)
				SKIN:Bang(SeO, 'LineC'..i, 'Hidden' ,'1')
			elseif mode == 3 then
				SKIN:Bang(SeO, 'Line'..i, 'LineStart' ,(130+Band[i]*100+OuterLength))
				SKIN:Bang(SeO, 'Line'..i, 'LineLength' ,(134+Band[i]*100+OuterLength))
			elseif mode == 4 then
				SKIN:Bang(SeO, 'Line'..i, 'LineStart' ,(136))
				SKIN:Bang(SeO, 'Line'..i, 'LineLength' ,(140+Band[i]*(100+OuterLength)))
				SKIN:Bang(SeO, 'Line'..i, 'LineColor' ,'#Color#,'..(50+Band[i]*220))
				SKIN:Bang(SeO, 'LineC'..i, 'LineStart' ,(131-Band[i]*(30+InnerLength)))
			elseif mode == 5 then
				SKIN:Bang(SeO, 'Line'..i, 'Hidden' ,1)
				SKIN:Bang(SeO, 'LineC'..i, 'LineWidth' ,287+Lnum-90+OuterLength)
				SKIN:Bang(SeO, 'LineC'..i, 'LineStart' ,127-OuterWidth+4)
			end

		end
end

function Wave( ... )
	for i = 1,Lnum do
		SKIN:Bang(SeO, 'Band'..i, 'Type' ,'Band')
		--SKIN:Bang(SeO, 'Band'..i, 'BandIdx' ,(i+60))
	end
	for i = 1,(Lnum/2) do
		SKIN:Bang(SeO, 'Band'..i, 'Channel' ,'R')
		SKIN:Bang(SeO, 'Band'..i, 'BandIdx' ,(i))
	end
	for i = (Lnum/2+1),Lnum do
		SKIN:Bang(SeO, 'Band'..i, 'Channel' ,'L')
		if mode ~= 4 then
			SKIN:Bang(SeO, 'Band'..i, 'BandIdx' ,(i-Lnum/2))
		else
			SKIN:Bang(SeO, 'Band'..i, 'BandIdx' ,(Lnum+1-i))
		end
	end
end

function MoveTime( ... )
		local x = SKIN:GetVariable("CURRENTCONFIGX")
		local y = SKIN:GetVariable("CURRENTCONFIGY")+5
		SKIN:Bang("!Move", x, y, "#ROOTCONFIG#\\time")
end

function Mode( ... )
	mode=tonumber(SKIN:GetVariable('Mode', 'n/a'))
	if mode ~= 3 then Wave() end
	if mode < 1 then mode = 1 end
	if mode > 5 then mode = 1 end
end

function Lnumf( ... )
	Lnum = tonumber(SKIN:GetVariable('Amount', 'n/a'))
	if Lnum < 0 then Lnum = 0 end
	if Lnum > 90 then Lnum = 90 end
	--if math.fmod(Lnum,2) == 1 then Lnum = Lnum + 1 end
end

function LineGet( ... )
	InnerWidth = tonumber(SKIN:GetVariable('InnerWidth','n/a'))
	InnerLength = tonumber(SKIN:GetVariable('InnerLength','n/a'))
	OuterWidth = tonumber(SKIN:GetVariable('OuterWidth','n/a'))
	OuterLength = tonumber(SKIN:GetVariable('OuterLength','n/a'))
end