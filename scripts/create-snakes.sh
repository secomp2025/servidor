#!/bin/bash

basedir=$(dirname "$0")/..

workspace_dir="$basedir/config/workspace"
snake_template_dir="$workspace_dir/snake-template"

N_SNAKES=50

do_force=false

if [ "$1" == "--force" ]; then
    do_force=true
fi

for i in $(seq 1 $N_SNAKES); do
    snake_dir="$workspace_dir/snake-$i"
    if [ -d "$snake_dir" ]; then
        if [ "$do_force" = false ]; then
            echo "Snake directory already exists: $snake_dir. Use --force to overwrite."
            continue
        fi
    fi

    echo "Creating snake directory: $snake_dir"
    mkdir -p "$snake_dir"

    cp -r $snake_template_dir/* "$snake_dir/"
    cat << EOF > "$snake_dir/run"
#!/bin/bash
python main.py
EOF
    chmod +x "$snake_dir/run"

    snake_port=$((5000 + i - 1))
    sed -i "s/# os.environ\[\"PORT\"\] = .*/os.environ\[\"PORT\"\] = \"$snake_port\"/" "$snake_dir/server.py"
    sed -i "s|f\"..Running Battlesnake at .*\"|\""'\\n'"Running Battlesnake at https://secomp.reverse-toad.ts.net/snake/$i\"|" "$snake_dir/server.py"

    echo "Snake $i created in $snake_dir"
done