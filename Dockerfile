FROM archlinux AS base

RUN echo "Configuring pacman" \
    sed -i 's/#Color/Color/g' /etc/pacman.conf \
    sed -i 's/#ParallelDownloads = 5/ParallelDownloads = 5/g' /etc/pacman.conf

RUN pacman -Syu --noconfirm

RUN pacman -S --noconfirm git \
    aws-cli \
    bat \
    btop \
    clang \
    cmake \
    curl \
    dnsutils \
    dotnet-sdk \
    # netcoredbg \
    fakeroot \
    fd \
    fzf \
    eza \
    gcc \
    gcc \
    jq \
    less \
    make \
    mono \
    mono-msbuild \
    ncdu \
    neovim \
    nginx \
    nuget \
    openssh \
    python-pip \
    ranger \
    ripgrep \
    sshfs \
    stow \
    sudo \
    tmux \
    unzip \
    upterm \
    vifm \
    wget \
    fish \
    xclip \
    yq \
    zip \
    zoxide \
    zsh

# Setup Build user so that we can install AUR packages
# FROM: https://bbs.archlinux.org/viewtopic.php?id=229027
RUN useradd --no-create-home --shell=/bin/zsh build && usermod -L build
RUN echo "build ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN echo "root ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
# user su build to switch, install aur package using git clone


WORKDIR /root/
# RUN echo -e "\033[32m Clone dotfiles\033[0m" && \
#     git clone https://github.com/enchantednatures/.dotfiles
# WORKDIR /root/.dotfiles
# RUN ls -lkha


RUN locale-gen en_US.UTF-8
ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

RUN echo -e "\033[32m Change Default Shell\033[0m" && \
    chsh -s /bin/fish root



RUN echo -e "\033[32m Install NVM\033[0m" && \
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash && \
    . /root/.nvm/nvm.sh && \
    nvm install --lts && \
    nvm use --lts

# THIS IS WHERE WE WILL MOUNT OUR HOST PROJECT VOLUME
RUN mkdir -p /mnt/c/Projects.Git


# Avoid container exit.
CMD ["tail", "-f", "/dev/null"]
