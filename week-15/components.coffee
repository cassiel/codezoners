/** @jsx React.DOM */

var ResultLine = React.createClass({displayName: 'ResultLine',
    getInitialState: function () {
        return {x: 0, y: 0, z: 0, t: 0};
    },

    setValue: function (a) {
        this.setState({x: a[3], y: a[2], z: a[1], t: a[0]});
        console.log(this.state.x, this.state.y, this.state.z, this.state.t);
    },

    render: function() {
        return React.DOM.div(null, 
            React.DOM.div(null, "T ", this.state.t),
            React.DOM.div(null, "Z ", this.state.z),
            React.DOM.div(null, "Y ", this.state.y),
            React.DOM.div(null, "X ", this.state.x)
        );
    }
});

var mountedContent = React.renderComponent(ResultLine(null ), document.getElementById("target"));

var calc = Calculator(mountedContent);
