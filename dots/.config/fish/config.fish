if status is-interactive
    starship init fish | source
    neofetch
    alias screenshot="grim ~/Pictures/Screenshots/(date +%Y-%m-%d-%H%M%S).png"
    function y
        yazi
    end
    
end


fish_add_path /home/tuesday/.spicetify
