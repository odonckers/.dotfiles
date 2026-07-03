import { spawn } from "node:child_process";

const HOOK = `${process.env.HOME}/.config/tmux/custom_plugins/ai-workflow/hooks/opencode.sh`;

function report(event, message = "") {
  const child = spawn(HOOK, [event, message], {
    detached: true,
    env: process.env,
    stdio: "ignore",
  });
  child.unref();
}

function sessionStatusType(event) {
  return event?.properties?.status?.type;
}

async function server() {
  return {
    async event(input) {
      const event = input.event;

      switch (event.type) {
        case "permission.asked":
        case "permission.updated":
          report("PermissionRequest", "permission needed");
          break;
        case "question.asked":
          report("PermissionRequest", "answer needed");
          break;
        case "message.part.delta":
        case "message.part.updated":
        case "command.executed":
          report("running", "working");
          break;
        case "permission.replied":
        case "question.replied":
        case "question.rejected":
          report("running", "working");
          break;
        case "session.status":
          if (sessionStatusType(event) === "busy") {
            report("running", "working");
          } else if (sessionStatusType(event) === "idle") {
            report("idle");
          } else if (sessionStatusType(event) === "retry") {
            report("running", event.properties.status.message || "retrying");
          }
          break;
        case "session.idle":
          report("idle");
          break;
      }
    },
    async "chat.message"() {
      report("running", "working");
    },
    async "permission.ask"() {
      report("PermissionRequest", "permission needed");
    },
    async "command.execute.before"() {
      report("running", "working");
    },
    async "tool.execute.before"() {
      report("running", "using tool");
    },
    async "tool.execute.after"() {
      report("running", "working");
    },
  };
}

export { server };
export default {
  id: "tmux-ai-workflow",
  server,
};
