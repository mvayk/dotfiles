import os
import subprocess

ROOT = os.path.dirname(os.path.abspath(__file__))
SKIP_DIRS = {".git", "target", ".idea", ".vscode", "node_modules"}
SKIP_FILES = {"Cargo.lock", ".DS_Store", os.path.basename(__file__), ".noctalia-cache.json"}

def collect_output():
    parts = []
    for dirpath, dirnames, filenames in os.walk(ROOT):
        dirnames[:] = sorted(d for d in dirnames if d not in SKIP_DIRS)
        for name in sorted(filenames):
            if name in SKIP_FILES:
                continue
            path = os.path.join(dirpath, name)
            rel = os.path.relpath(path, ROOT).replace(os.sep, "/")
            try:
                with open(path, encoding="utf-8") as f:
                    content = f.read()
            except UnicodeDecodeError:
                continue
            parts.append(f">{rel}:\n{content}\n")
    return "\n".join(parts)


if __name__ == "__main__":
    subprocess.run(["wl-copy"], input=collect_output().encode("utf-8"), check=True)
