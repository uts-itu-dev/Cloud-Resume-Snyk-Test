

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

fetch("https://7qui4v5ceqdqbmhxy265im3frq0ulaei.lambda-url.ap-southeast-2.on.aws/")
        .then((Response) => Response.json())
        .then((RetVal) => {
                Metric = RetVal
                Tick();
        });