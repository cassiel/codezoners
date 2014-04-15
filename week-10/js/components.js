/** @jsx React.DOM */

var ResultLine = React.createClass({
    getInitialState: function () {
        return {value: 0};
    },

    setValue: function (n) {
        this.setState({value: n});
    },

    render: function() {
        return <div>{this.state.value}</div>;
    }
});

var newContent = <ResultLine />;

var calc = Calculator(newContent);

React.renderComponent(newContent, document.getElementById("target"));
