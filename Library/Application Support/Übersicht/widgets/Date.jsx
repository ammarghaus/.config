const command = 'date +"%A, %d %B | %T"';

const refreshFrequency = 1000;

const fontInfo = {
    color: '#00FF00',
    font: '14px Hack Nerd Font Mono',
    background: '#000000'
}

const className = {
    ...fontInfo,
    bottom: '98%',
    right: '1%',
    textAlign: 'right',
    opacity: 0.7
};

const render = ({output}) => <div> {output} </div>;

export {command, refreshFrequency, className, render, fontInfo}
