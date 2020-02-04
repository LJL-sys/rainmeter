--[[
Name = CPUCore.lua
Author = 雪月花
Vertion = 1.0
License = CC BY - NC - SA 4.0
Information = 脚本用于调整CPU核心数目显示
]]

function SetCore(N)
	local Scale=tonumber(SELF:GetOption('T/C',2))
	local Interval=tonumber(SELF:GetOption('NextInterval'))
	local Default=tonumber(SELF:GetOption('NextPos'))
	local Max=tonumber(SELF:GetOption('MaxCore'))
	local Cores=math.floor(tonumber(N)/Scale)
	if Cores >Max then Cores=10 end
	local Pos= Default-Interval*(Max-Cores)
	for i=1,Cores do
		SKIN:Bang('!EnableMeasure','mCPU'..i)
		SKIN:Bang('!ShowMeterGroup','CPU'..i)
	end
	SKIN:Bang('!SetOption','RAMImage','Y',Pos..'r')
	SKIN:Bang('!Update')
end

