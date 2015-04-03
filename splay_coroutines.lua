require"splay.base"
events=require"splay.events"

events.run(function()
	for i=1,8 do 	
		events.thread(function()
			local f=io.open("/tmp/"..i..".txt","w")
			for b=1,1024*512 do 
				f:write("0")
				events.yield()
			end
			f:close()	
		end)
	end
end)
