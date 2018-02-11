using System.Collections.Generic;
//using UnityEngine.UI;
//using UnityEditor;
using UnityEngine;
using System;


namespace Labo{
    public class WaterFlow : MonoBehaviour{
        [SerializeField] private Vector2 MainFlow = new Vector2(0.01f, 0.01f);
        [SerializeField] private Vector2 DetailFlow = new Vector2(-0.013f, 0);
        [SerializeField] private Material waterMaterial;

        private void Update() {
            if (waterMaterial == null) { return; }
            waterMaterial.SetTextureOffset("_MainTex", MainFlow * Time.time);
            waterMaterial.SetTextureOffset("_DetailAlbedoMap", DetailFlow * Time.time);
        }
    }
}