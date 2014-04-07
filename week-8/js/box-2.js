/** @jsx React.DOM */

// Box class:

function makeColourAttribute(i) {
    return "rgb(" + i + ", " + i + ", " + i + ")";
}

var MyBox = React.createClass( {
    render: function () {
        return <div style={ {width: "50px",
                             height: "50px",
                             'background-color':
                                 makeColourAttribute(this.props.brightness)} }></div>;
    }
} );

var BoxSet = React.createClass( {
    render: function () {
        return <div>{this.props.children}</div>;
    }
});


// The BAD way to iterate over a set of children (React can't react to changes):

var myBoxes = [
         <MyBox brightness="128" />,
         <MyBox brightness="200" />,
         <MyBox brightness="0" />,
         <MyBox brightness="30" />,
         <MyBox brightness="80" />
];

React.renderComponent(
    <BoxSet>{myBoxes}</BoxSet>,
    document.getElementById("container")
);
