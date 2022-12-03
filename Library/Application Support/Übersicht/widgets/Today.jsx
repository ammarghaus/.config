const command = '/Users/ammar/scripts/today';

const refreshFrequency = 1000;

const fontInfo = {
    color: '#00FF00',
    font: '14px Hack Nerd Font Mono',
	background: '#000000'
}

const className = {
    ...fontInfo,
    top: '.5%',
    right: '18%',
    textAlign: 'left',
	whiteSpace: 'pre-line',
	opacity: 0.7
};

const render = ({output}) => <div> {output} </div>;

export {command, refreshFrequency, className, render, fontInfo}
