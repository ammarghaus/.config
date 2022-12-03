const command = '/Users/ammar/scripts/stories 2>/dev/null';

const refreshFrequency = 300000;

const fontInfo = {
    color: '#00FF00',
    font: '14px Hack Nerd Font Mono',
	background: '#000000'
}

const className = {
    ...fontInfo,
    top: '2.5%',
    left: '1%',
    textAlign: 'left',
	whiteSpace: 'pre-line',
	opacity: 0.7
};

const render = ({output}) => <div> {output} </div>;

export {command, refreshFrequency, className, render, fontInfo}
