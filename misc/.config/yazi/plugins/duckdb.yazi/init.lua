local M = {}

function M:peek(job)
	local child = Command("duckdb")
		:args({
			"-c",
			"DESCRIBE SELECT * FROM '" .. tostring(job.file.url) .. "' LIMIT 10;",
		})
		:stdout(Command.PIPED)
		:stderr(Command.PIPED)
		:spawn()

	if not child then
		return
	end

	local limit = job.area.h
	local i, lines = 0, ""
	repeat
		local next, event = child:read_line()
		if event == 1 then
			break
		end
		lines = lines .. next
		i = i + 1
	until i >= limit

	child:kill()
	ya.preview_code(job, lines)
end

function M:seek(job) end

return M
