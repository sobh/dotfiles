// Pi and Oh-My-Pi extension: run the shared shell guard before bash tool calls.
// The guard script sits beside this file; resolve symlinks to find it.
import { spawnSync } from "node:child_process";
import { realpathSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";

// Only the parts of the harness API this extension uses.
interface ToolCallEvent {
	toolName: string;
	input?: { command?: unknown };
}
interface Block {
	block: true;
	reason: string;
}
interface Extensions {
	on(
		event: "tool_call",
		handler: (event: ToolCallEvent) => Promise<Block | undefined>,
	): void;
}

const guard = join(
	dirname(realpathSync(fileURLToPath(import.meta.url))),
	"guard-shell.sh",
);

export default function (pi: Extensions) {
	pi.on("tool_call", async (event) => {
		if (event.toolName !== "bash") return;
		const result = spawnSync("sh", [guard], {
			input: JSON.stringify({
				tool_input: { command: String(event.input?.command ?? "") },
			}),
			encoding: "utf8",
		});
		// Exit 2 blocks; other failures leave the call unblocked, as in Claude.
		if (result.status === 2) {
			return { block: true, reason: result.stderr.trim() };
		}
	});
}
