sampler2D Texture0;
sampler2D noiseTexture;
float2 TexSize;
float QuantLevel;
float WaterPower;

float4 quant(inout float4 cl, float n)
{
    cl.rgb = int3(cl.rgb * 255 / n) * n / 255;
    return cl;
}

float4 ps_main( float2 texCoord  : TEXCOORD0 ) : COLOR
{
    float4 noiseColor = WaterPower * tex2D(noiseTexture, texCoord);
    float2 newUV = texCoord + noiseColor.rg / TexSize;
    float4 fColor = tex2D(Texture0, newUV);
   return quant(fColor, 255 / pow(2, QuantLevel));
}

