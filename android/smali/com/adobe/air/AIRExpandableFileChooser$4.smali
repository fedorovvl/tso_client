.class Lcom/adobe/air/AIRExpandableFileChooser$4;
.super Ljava/lang/Object;
.source "AIRExpandableFileChooser.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/adobe/air/AIRExpandableFileChooser;->createInvisibleMultipleFileSelectionView()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/adobe/air/AIRExpandableFileChooser;


# direct methods
.method constructor <init>(Lcom/adobe/air/AIRExpandableFileChooser;)V
    .locals 0
    .param p1, "this$0"    # Lcom/adobe/air/AIRExpandableFileChooser;

    .prologue
    .line 508
    iput-object p1, p0, Lcom/adobe/air/AIRExpandableFileChooser$4;->this$0:Lcom/adobe/air/AIRExpandableFileChooser;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 8
    .param p1, "dialog"    # Landroid/content/DialogInterface;
    .param p2, "whichButton"    # I

    .prologue
    .line 511
    iget-object v6, p0, Lcom/adobe/air/AIRExpandableFileChooser$4;->this$0:Lcom/adobe/air/AIRExpandableFileChooser;

    invoke-static {v6}, Lcom/adobe/air/AIRExpandableFileChooser;->access$800(Lcom/adobe/air/AIRExpandableFileChooser;)Ljava/util/ArrayList;

    move-result-object v6

    invoke-virtual {v6}, Ljava/util/ArrayList;->clear()V

    .line 512
    iget-object v6, p0, Lcom/adobe/air/AIRExpandableFileChooser$4;->this$0:Lcom/adobe/air/AIRExpandableFileChooser;

    invoke-static {v6}, Lcom/adobe/air/AIRExpandableFileChooser;->access$500(Lcom/adobe/air/AIRExpandableFileChooser;)Ljava/util/List;

    move-result-object v6

    invoke-interface {v6}, Ljava/util/List;->size()I

    move-result v5

    .line 513
    .local v5, "numGroups":I
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_0
    if-ge v2, v5, :cond_2

    .line 515
    iget-object v6, p0, Lcom/adobe/air/AIRExpandableFileChooser$4;->this$0:Lcom/adobe/air/AIRExpandableFileChooser;

    invoke-static {v6}, Lcom/adobe/air/AIRExpandableFileChooser;->access$400(Lcom/adobe/air/AIRExpandableFileChooser;)Ljava/util/List;

    move-result-object v6

    invoke-interface {v6, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/util/List;

    invoke-interface {v6}, Ljava/util/List;->size()I

    move-result v4

    .line 516
    .local v4, "numChildren":I
    const/4 v3, 0x0

    .local v3, "j":I
    :goto_1
    if-ge v3, v4, :cond_1

    .line 518
    iget-object v6, p0, Lcom/adobe/air/AIRExpandableFileChooser$4;->this$0:Lcom/adobe/air/AIRExpandableFileChooser;

    invoke-static {v6, v2, v3}, Lcom/adobe/air/AIRExpandableFileChooser;->access$100(Lcom/adobe/air/AIRExpandableFileChooser;II)I

    move-result v1

    .line 519
    .local v1, "flatPosition":I
    iget-object v6, p0, Lcom/adobe/air/AIRExpandableFileChooser$4;->this$0:Lcom/adobe/air/AIRExpandableFileChooser;

    invoke-static {v6}, Lcom/adobe/air/AIRExpandableFileChooser;->access$300(Lcom/adobe/air/AIRExpandableFileChooser;)Landroid/util/SparseBooleanArray;

    move-result-object v6

    invoke-virtual {v6, v1}, Landroid/util/SparseBooleanArray;->get(I)Z

    move-result v6

    if-eqz v6, :cond_0

    .line 521
    iget-object v6, p0, Lcom/adobe/air/AIRExpandableFileChooser$4;->this$0:Lcom/adobe/air/AIRExpandableFileChooser;

    invoke-static {v6}, Lcom/adobe/air/AIRExpandableFileChooser;->access$1100(Lcom/adobe/air/AIRExpandableFileChooser;)Landroid/widget/ExpandableListAdapter;

    move-result-object v6

    invoke-interface {v6, v2, v3}, Landroid/widget/ExpandableListAdapter;->getChild(II)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/HashMap;

    .line 522
    .local v0, "child":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Lcom/adobe/air/AIRExpandableFileChooser$FileInfo;>;"
    iget-object v6, p0, Lcom/adobe/air/AIRExpandableFileChooser$4;->this$0:Lcom/adobe/air/AIRExpandableFileChooser;

    invoke-static {v6}, Lcom/adobe/air/AIRExpandableFileChooser;->access$800(Lcom/adobe/air/AIRExpandableFileChooser;)Ljava/util/ArrayList;

    move-result-object v7

    const-string v6, "FILEINFO"

    invoke-interface {v0, v6}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Lcom/adobe/air/AIRExpandableFileChooser$FileInfo;

    iget-object v6, v6, Lcom/adobe/air/AIRExpandableFileChooser$FileInfo;->mFilePath:Ljava/lang/String;

    invoke-virtual {v7, v6}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 516
    .end local v0    # "child":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Lcom/adobe/air/AIRExpandableFileChooser$FileInfo;>;"
    :cond_0
    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    .line 513
    .end local v1    # "flatPosition":I
    :cond_1
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 527
    .end local v3    # "j":I
    .end local v4    # "numChildren":I
    :cond_2
    iget-object v6, p0, Lcom/adobe/air/AIRExpandableFileChooser$4;->this$0:Lcom/adobe/air/AIRExpandableFileChooser;

    invoke-static {v6}, Lcom/adobe/air/AIRExpandableFileChooser;->access$600(Lcom/adobe/air/AIRExpandableFileChooser;)Lcom/adobe/air/FileChooserStub;

    move-result-object v6

    const-string v7, "done"

    invoke-virtual {v6, v7}, Lcom/adobe/air/FileChooserStub;->SetUserAction(Ljava/lang/String;)V

    .line 528
    return-void
.end method
