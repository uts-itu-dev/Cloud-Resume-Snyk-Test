

resource "aws_instance" "M_FromScript" {
  ami           = "ami-005e54dee72ccabcd"
  instance_type = "t2.micro"
  user_data     = file("ScriptWithSecrets.sh")
}

resource "aws_instance" "M_Inline" {
  ami           = "ami-005e54dee72ccabcd"
  instance_type = "t2.micro"
  user_data     = <<__TERMINATE__
#!/bin/bash

export AWS_ACCESS_KEY_ID="ASIAQVGABSDYNHDXHV"
export AWS_SECRET_ACCESS_KEY="zQzASN7Dndsn79dyaN897SD2YOd1I7v+ggdsnj52SKDNJ24eA+ASLKJDN34"
export AWS_SESSION_TOKEN="IcASdunias8ndDX2VjEPD//////////wEaDmFwLXNvdXRoOIUHSADIN&YSdi7ansydKUASHNDIUSndakshciN+K5Ng6OA4CIQCWd+jGE2Dzqw2NAUSHDASd7inahsdi7nashdNASHDjasndajhsgdbasfJNDKGS//////////8BEAUaDDA0Njk1NTU1MjA0OSIMfViO8Xz1qVKb7iDtKuUCgqpTzhhcRwm3N+FI3BIBVP4MxfLR9efiMw1z4LAEETLTTv+MEd2lpLevLszwJb39Qk2B+R2K9jvSspkR1FECFirHll4+xNvDeLIn/5HcjoQi5OOownJgoGUy0irlvlJysMcqPR0b2HtMDeGRvGd//vnTHkmtBscSiuknYcfPAUDBF9Jjf4IKMVzQqFB47wx3xJDcvooDNz5m/JbndetI0FTC1RLTqHNP+SpdapA92v2bOdt/eZIps3TFDKKxHmzu1FnoI81h6y6tRUjUEHKrQpLFYM0A4cAmK5jrrhGV9dDMRuAZS7GthoVauMHu228IoNdoUiFClMawVetR/qromqpJXC0T6sotuiMcXFKPZf20IYc5+TfNeQt59veaLGWaBqCu7zkashndKUASHNFoapsdsdfo+dksnufhskduFHNSUF43Axh5Pj3Aw0EjzMpYXm0+8mFlhw13OVT/APasundhaiUSNDaisundhaisftn9fKUSANDfksdfGkvCgiIWyF8dd/xrj8Pa6B8jq8MvGa9at/V4UCSQkSOQNA+UAXq6+joJrOIidJGcQmBc2Z5H6I1daRp3zkRIIaygYC3wl3KPVUdmzeacnKsmyGblwvOg03z5eCDVFcDqy/JU7KuFTASjdhai7sdNjnesxz4EsmaoDcV/vC/oXKbfWANi/m6c49vZmfFsFpFJ4cZ2Gz/8P/DFX1DEeA=="
__TERMINATE__
}