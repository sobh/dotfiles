// OpenCode plugin: run the shared shell guard before bash tool calls.
// Uses the V1 plugin shape, which OpenCode V2 also loads.
import { spawnSync } from "node:child_process";
import { realpathSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";

// Only the parts of the hook arguments this plugin uses.
interface ToolInfo {
	tool: string;
}
interface ToolArguments {
	args?: { command?: unknown };
}

const guard = join(
	dirname(realpathSync(fileURLToPath(import.meta.url))),
	"guard-shell.sh",
);

export const AiGuard = async () => ({
	"tool.execute.before": async (input: ToolInfo, output: ToolArguments) => {
		if (input.tool !== "bash") return;
		const result = spawnSync("sh", [guard], {
			input: JSON.stringify({
				tool_input: { command: String(output.args?.command ?? "") },
			}),
			encoding: "utf8",
		});
		// Throwing blocks the call; exit 1 (invalid input) stays non-blocking.
		if (result.status === 2) throw new Error(result.stderr.trim());
	},
});
