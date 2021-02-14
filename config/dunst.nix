{ pkgs, config, lib, ... }:

with lib;
{
  config = mkIf config.modules.services.dunst.enable {
    services.dunst.settings = {
      global = {
        # Which monitor should the notification be displayed on
        monitor = 0;

        follow = "mouse";

        # The geometry of the window
        geometry = "450x10-10+48";

        # Show how many messages are currently hidden (because of geometry)
        indicate_hidden = true;

        # Draw a line of "separator_height" pixel height between two notifications
        separator_height = 0;

        # Padding between text and separator
        padding = 10;

        # Horizontal padding
        horizontal_padding = 10;

        # Defines width in pixels of frame around the notification window
        # Set to 0 to disable
        frame_width = 2;

        # Defines color of the frame around the notification window
        frame_color = "#363636";

        # Defines a color for the separator
        separator_color = "#bfbfbf";

        # Sort messages by urgency
        sort = true;

        # Don't remove messages, if the user is idle (no mouse or keyboard input)
        # for longer than "idle_threshold" seconds
        idle_threshold = 120;


        font = "FontAwesome 10";

        # The spacing between lines. If the height is smaller than the
        # font height, it will get raised to the font height
        line_height = 0;

        # Possible values are:
        # full: Allow a small subset of html markup in notifications:
        #        <b>bold</b>
        #        <i>italic</i>
        #        <s>strikethrough</s>
        #        <u>underline</u>
        #
        #        For a complete reference see
        #        <http://developer.gnome.org/pango/stable/PangoMarkupFormat.html>
        #
        # strip: This setting is provided for compatibility with some broken
        #        clients that send markup even thought it's not enabled on the
        #        server. Dunst will try to string the markup but the parsing is
        #        simplistic so using this option outside of matching rules for
        #        specific applications *IS GREATLY DISCOURAGED*
        #
        # no:    Disable markup parsing, incoming notifications will be treated as
        #        plain text. Dunst will not advertise that it has the body-markup
        #        capability if this is set as a global setting
        #
        # It's important to note that markup inside the format option will be parsed
        # regardless of what this is set to
        markup = "full";

        # The format of the message. possible variables are:
        #   %a  appname
        #   %s  summary
        #   %b  body
        #   %i  iconname (including its path)
        #   %I  iconname (without its path)
        #   %p  progress value if set ([  0%] to [100%]) or nothing
        #   %n  progress value if set without any extra characters
        #   %%  literal %
        # Markup is allowed
        format = "<big><b>%s</b></big>\\n──────────────────────────────────────────\\n%b<small><sub>\\n\\n%a</sub></small>";

        # Alignment of message text
        # Possible values are "left", "center" and "right"
        alignment = "left";

        # Show age of message if message if older than "show_age_threshold"
        # seconds
        # Set to -1 to disable
        show_age_threshold = 60;

        # Split notifications into multiple lines if the don't fit into
        # geometry
        word_wrap = true;

        # When "word_wrap" is set to no, specify where to make an ellipsis in long lines
        # Possible values are "start", "middle" and "end"
        ellipsize = "end";

        # Ignore newlines '\n' in notifications
        ignore_newline = false;

        # Stack together notifications with the same content
        stack_duplicates = true;

        # Hide the count of stacked notifications with the same content
        hide_duplicate_count = true;

        # Display indicators for URLs (U) and actions (A)
        show_indicators = false;


        # Align icons left/right/off
        icon_position = "left";

        # Scale larger icons down to this size, set to 0 to disable
        max_icon_size = 48;

        # Path to default icons
        # icon_path = "";

        vertical_alignment = "top";


        # Should a notification popped up from history be sticky or timeout
        # as if it would normally do
        sticky_history = true;

        # Maximum amount of notifications kept in history
        history_length = 20;


        # Menu for commands
        dmenu = "${pkgs.rofi}/bin/rofi -dmenu -p dunst";

        # Browser for opening urls in context menu
        browser = "${pkgs.brave}/bin/brave --new-tab";

        # Always run rule-defined scripts, even if the notification is suppressed
        always_run_script = true;

        # Define the title of the windows spawned by dunst
        title = "Dunst";

        # Define the class of the windows spawned by dunst
        class = "Dunst";

        # Print a notification on startup
        startup_notification = false;

        # Manage dunst's desire for talking
        # Can be one of the following values:
        #  crit: Critical features. Dunst aborts
        #  warn: Only non-fatal warnings
        #  mesg: Important messages
        #  info: all unimportant stuff
        # debug: all less than unimportant stuff
        verbosity = "mesg";

        # Define the corner radius of the notification window
        corner_radius = 2;


        mouse_left_click = "close_current";
        mouse_middle_click = "do_action";
        mouse_right_click = "close_all";
      };

      frame = {
        color = "#212121";
        width = 0;
      };

      urgency_low = {
        background = "#212121";
        foreground = "#ed82b4";
        timeout = 5;
      };

      urgency_normal = {
        background = "#212121";
        foreground = "#dddddd"; #"#f55ba3";
        timeout = 5;
      };

      urgency_critical = {
        background = "#212121";
        foreground = "#cf0e68";
        timeout = 0;
      };
    };
  };
}
