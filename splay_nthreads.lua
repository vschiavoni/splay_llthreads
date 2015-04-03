local llthreads = require"llthreads"
require"splay.base"
events=require"splay.events"


local native_thread_code = [[
    local filename_index=select(1,...)
	local write_path=select(2,...)
	local f=io.open(write_path..filename_index..".txt","w")
	for b=1,1000*1000*1000 do --1gb
		f:write("0\n")
	end
	f:close()	
]]

events.run(function()
	local thread=nil
	for i=1,8 do 	
		thread = llthreads.new(native_thread_code, i,"/tmp/")
		assert(thread:start()) --joinable thread, don't care when this thread finishes		
		--the splay way:
		--events.thread(function()
		--	local f=io.open("/tmp/"..i..".txt","w")
		--	for b=1,1000*1000*1000 do --1gb
		--		f:write("0\n")
		--		events.yield()
		--	end
		--	f:close()	
		--end)
	end
	thread:join() --wait only for the last one, llthreads do not provide thread barriers
end)
