# Emacs Org Instant Preview

A portable Emacs Org Mode setup with instant HTML preview and auto-refresh functionality.

## Features

- Automatic HTML export on save
- Instant preview using Emacs' built-in `eww` browser
- Auto-refresh preview on each save
- Automatic package installation
- Maximized Emacs window on startup

## Installation

1. Clone this repository:
   ```
   git clone https://github.com/yourusername/emacs-org-instant-preview.git
   ```
2. Copy the `.dir-locals.el` file to your Org Mode project directory.

## Usage

1. Open any `.org` file in the directory containing the `.dir-locals.el` file.
2. Emacs will automatically maximize, export the Org file to HTML, and show a preview.
3. As you edit and save the Org file, the preview will automatically update.

## Requirements

- Emacs 25.1 or later
- Internet connection (for initial package installation)

## Customization

You can modify the `.dir-locals.el` file to change the behavior or add more functionality.

## License

This project is licensed under the WTFPL - see the [LICENSE](https://en.wikipedia.org/wiki/WTFPL) for details.

## Contributing

Contributions, issues, and feature requests are welcome!

## Acknowledgements

- The Emacs community
- Org Mode developers

Enjoy your enhanced Org Mode experience!