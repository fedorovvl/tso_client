.class Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem$1;
.super Ljava/lang/Object;
.source "AIRExpandableFileChooser.java"

# interfaces
.implements Landroid/widget/CompoundButton$OnCheckedChangeListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem;-><init>(Lcom/adobe/air/AIRExpandableFileChooser;Landroid/view/LayoutInflater;Landroid/content/res/Resources;Landroid/view/ViewGroup;II)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem;

.field final synthetic val$this$0:Lcom/adobe/air/AIRExpandableFileChooser;


# direct methods
.method constructor <init>(Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem;Lcom/adobe/air/AIRExpandableFileChooser;)V
    .locals 0
    .param p1, "this$1"    # Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem;

    .prologue
    .line 115
    iput-object p1, p0, Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem$1;->this$1:Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem;

    iput-object p2, p0, Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem$1;->val$this$0:Lcom/adobe/air/AIRExpandableFileChooser;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onCheckedChanged(Landroid/widget/CompoundButton;Z)V
    .locals 2
    .param p1, "buttonView"    # Landroid/widget/CompoundButton;
    .param p2, "isChecked"    # Z

    .prologue
    .line 118
    iget-object v0, p0, Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem$1;->this$1:Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem;

    invoke-static {v0}, Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem;->access$200(Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem;)I

    move-result v0

    if-gez v0, :cond_0

    .line 132
    :goto_0
    return-void

    .line 124
    :cond_0
    if-eqz p2, :cond_1

    .line 126
    iget-object v0, p0, Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem$1;->this$1:Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem;

    iget-object v0, v0, Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem;->this$0:Lcom/adobe/air/AIRExpandableFileChooser;

    invoke-static {v0}, Lcom/adobe/air/AIRExpandableFileChooser;->access$300(Lcom/adobe/air/AIRExpandableFileChooser;)Landroid/util/SparseBooleanArray;

    move-result-object v0

    iget-object v1, p0, Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem$1;->this$1:Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem;

    invoke-static {v1}, Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem;->access$200(Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem;)I

    move-result v1

    invoke-virtual {v0, v1, p2}, Landroid/util/SparseBooleanArray;->put(IZ)V

    goto :goto_0

    .line 130
    :cond_1
    iget-object v0, p0, Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem$1;->this$1:Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem;

    iget-object v0, v0, Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem;->this$0:Lcom/adobe/air/AIRExpandableFileChooser;

    invoke-static {v0}, Lcom/adobe/air/AIRExpandableFileChooser;->access$300(Lcom/adobe/air/AIRExpandableFileChooser;)Landroid/util/SparseBooleanArray;

    move-result-object v0

    iget-object v1, p0, Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem$1;->this$1:Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem;

    invoke-static {v1}, Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem;->access$200(Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/util/SparseBooleanArray;->delete(I)V

    goto :goto_0
.end method
