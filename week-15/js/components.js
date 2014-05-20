/** @jsx React.DOM */

var ResultLine = React.createClass({
    getInitialState: function () {
        return {x: 0, y: 0, z: 0, t: 0};
    },

    setValue: function (a) {
        this.setState({x: a[3], y: a[2], z: a[1], t: a[0]});
        console.log(this.state.x, this.state.y, this.state.z, this.state.t);
    },

    render: function() {
        return <div>
            <div>T {this.state.t}</div>
            <div>Z {this.state.z}</div>
            <div>Y {this.state.y}</div>
            <div>X {this.state.x}</div>
        </div>;
    }
});

var mountedContent = React.renderComponent(<ResultLine />, document.getElementById("target"));

var calc = Calculator(mountedContent);
