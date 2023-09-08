

let Metric = 0;
let Current = 0;

function Tick()
{
        if (Current < Metric)
        {
                Current += 1;
                requestAnimationFrame(Tick);
        }

        document.getElementById("Metric").innerHTML = `You are visitor number: ${Current}`;
}

fetch("https://gzdq7cbc6alzn6lxxmbxpl2i5y0ihxsj.lambda-url.ap-southeast-2.on.aws/")
        .then((Response) => Response.json())
        .then((RetVal) => {
                Metric = RetVal
                Tick();
        });