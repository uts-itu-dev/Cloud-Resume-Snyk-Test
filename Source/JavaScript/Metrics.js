

let Metric = 0;

function Tick()
{
        if (Metric < 100)
        {
                Metric += 1;
                requestAnimationFrame(Tick);
        }

        document.getElementById("Metric").innerHTML = Metric;
}

Tick();

fetch("https://gzdq7cbc6alzn6lxxmbxpl2i5y0ihxsj.lambda-url.ap-southeast-2.on.aws/")
  .then((response) => response.json())
  .then((json) => console.log(json));