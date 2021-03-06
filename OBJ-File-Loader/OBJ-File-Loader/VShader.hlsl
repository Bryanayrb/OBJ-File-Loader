cbuffer ConstantBuffer
{
	float4x4 final;
	float4x4 rotation;
	float4 lightvec;
	float4 lightcol;
	float4 ambientcol;
};

struct VOut
{
	float4 position : SV_POSITION;
	float4 color : COLOR;
};

VOut VShader(float4 position : POSITION, float3 normal : NORMAL)
{
	VOut output;

	position.w = lightvec.w;

	output.position = mul(final, position);
	output.color = ambientcol;
	
	float4 lvec = lightvec;
		lvec.w = 0;

	float4 norm = normalize(mul(rotation, normal));
	float diffuse = saturate(dot(norm, lvec));

	output.color += lightcol * diffuse;

	return output;
}