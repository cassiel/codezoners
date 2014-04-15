/** @jsx React.DOM */

// Box class:

function makeColourAttribute(i) {
    return "rgb(" + i + ", " + i + ", " + i + ")";
}

var MyBox = React.createClass( {
    deleteMe: function () {
        var theSet = this.props.enclosingSet;
        var theBoxes = theSet.state.myBoxes;

        // Clearly not this simple!!!
        alert("Looking for ", this);
        for (var i = 0; i < theBoxes.length; i++) {
            if (theBoxes[i] === this) {
                alert("index is ", index);
            }
        }

        //theBoxes.splice(index, 1);

        //theSet.setState({myBoxes: theBoxes});
    },

    render: function () {
      var rgb = makeColourAttribute("0");

        if (this.props.brightness !== undefined) {
            rgb = makeColourAttribute(this.props.brightness);
        } else if (this.props.colour !== undefined) {
            rgb = this.props.colour;
        } else {
            rgb = "rgb(255, 0, 0)";
        }

        return <div style={ {width: "100px",
                             height: "50px",
                           'background-color': rgb} }><button onClick={this.deleteMe}>Delete me!</button></div>;
    }
} );

// A set of boxes (stacked vertically div elements):

var BoxSet = React.createClass( {
    getInitialState: function () {
      return {myBoxes: []};
    },

    destroyBoxes: function () {
        this.setState( {myBoxes: []} );
    },

    addBox: function () {
      var a = this.state.myBoxes;
      a.push(<MyBox
             brightness={Math.round(Math.random() * 255)}
             enclosingSet={this} />);

      this.setState(
          {myBoxes: a}
      );
    },

    render: function () {
        return <div>
          {this.state.myBoxes}
          <button onClick={this.destroyBoxes}>Destroy!</button>
          <button onClick={this.addBox}>Add a box</button>
        </div>;
    }
});

var myBoxSet = <BoxSet />;

React.renderComponent(
    myBoxSet,
    document.getElementById("container")
);
