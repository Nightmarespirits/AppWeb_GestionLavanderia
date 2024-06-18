//No esta siendo usado

//Creacion del Componente TreeItem
export default{
name: 'TreeItem', // necessary for self-reference
props: {
  model: Object
},
data() {
  return {
    isOpen: false
  };
},
computed: {
  isFolder() {
    return this.model.children && this.model.children.length;
  }
},
methods: {
  toggle() {
    if (this.isFolder) {
      this.isOpen = !this.isOpen;

    }
  },
  clickItem(event) {
        // Emitir un evento personalizado con el nombre 'agregarDetalle' y pasando la prenda como dato
        this.$emit('click-item', event.target.textContent);
        console.log('clicked: ' +  event.target.textContent);

    },
  changeType() {
    if (!this.isFolder) {
      this.model.children = [];
      this.addChild();
      this.isOpen = true;
    }
  },
  addChild() {
    this.model.children.push({
      name: 'new stuff'
    });
  }
},
template: `
<li>
  <div
    :class="{ divPrendas: isFolder }"
    @click="isFolder ? toggle() : clickItem($event)">
    {{ model.name }}
    <span v-if="isFolder">[{{ isOpen ? '-' : '+' }}]</span>
  </div>
  <ul v-show="isOpen" v-if="isFolder">
    <!--
      A component can recursively render itself using its
      "name" option (inferred from filename if using SFC)
    -->
    <tree-item @click="clickItem($event)"
      class="item"
      v-for="model in model.children"
      :model="model" >
    </tree-item>
  </ul>
</li>
`
};
