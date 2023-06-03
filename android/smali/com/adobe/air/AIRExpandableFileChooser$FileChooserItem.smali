.class Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem;
.super Landroid/widget/LinearLayout;
.source "AIRExpandableFileChooser.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/adobe/air/AIRExpandableFileChooser;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "FileChooserItem"
.end annotation


# instance fields
.field private mFileCheckBox:Landroid/widget/CompoundButton;

.field private mFileNameView:Landroid/widget/TextView;

.field private mFilePathView:Landroid/widget/TextView;

.field private mListFlatPosition:I

.field private mListener:Landroid/widget/CompoundButton$OnCheckedChangeListener;

.field final synthetic this$0:Lcom/adobe/air/AIRExpandableFileChooser;


# direct methods
.method constructor <init>(Lcom/adobe/air/AIRExpandableFileChooser;Landroid/view/LayoutInflater;Landroid/content/res/Resources;Landroid/view/ViewGroup;II)V
    .locals 3
    .param p2, "inflater"    # Landroid/view/LayoutInflater;
    .param p3, "runtimeResources"    # Landroid/content/res/Resources;
    .param p4, "parent"    # Landroid/view/ViewGroup;
    .param p5, "groupPosition"    # I
    .param p6, "childPosition"    # I

    .prologue
    .line 98
    iput-object p1, p0, Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem;->this$0:Lcom/adobe/air/AIRExpandableFileChooser;

    .line 99
    invoke-static {}, Lcom/adobe/air/AndroidActivityWrapper;->GetAndroidActivityWrapper()Lcom/adobe/air/AndroidActivityWrapper;

    move-result-object v2

    invoke-virtual {v2}, Lcom/adobe/air/AndroidActivityWrapper;->getActivity()Landroid/app/Activity;

    move-result-object v2

    invoke-direct {p0, v2}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 94
    const/4 v2, -0x1

    iput v2, p0, Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem;->mListFlatPosition:I

    .line 101
    invoke-static {p1}, Lcom/adobe/air/AIRExpandableFileChooser;->access$000(Lcom/adobe/air/AIRExpandableFileChooser;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 103
    const-string v2, "expandable_multiple_chooser_row"

    invoke-static {v2, p3, p2}, Lcom/adobe/air/utils/Utils;->GetLayoutView(Ljava/lang/String;Landroid/content/res/Resources;Landroid/view/LayoutInflater;)Landroid/view/View;

    move-result-object v1

    .line 104
    .local v1, "layoutView":Landroid/view/View;
    invoke-virtual {v1}, Landroid/view/View;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    .line 105
    .local v0, "layoutResources":Landroid/content/res/Resources;
    const-string v2, "filename"

    invoke-static {v2, v0, v1}, Lcom/adobe/air/utils/Utils;->GetWidgetInViewByNameFromPackage(Ljava/lang/String;Landroid/content/res/Resources;Landroid/view/View;)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/TextView;

    check-cast v2, Landroid/widget/TextView;

    iput-object v2, p0, Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem;->mFileNameView:Landroid/widget/TextView;

    .line 106
    const-string v2, "filepath"

    invoke-static {v2, v0, v1}, Lcom/adobe/air/utils/Utils;->GetWidgetInViewByNameFromPackage(Ljava/lang/String;Landroid/content/res/Resources;Landroid/view/View;)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/TextView;

    check-cast v2, Landroid/widget/TextView;

    iput-object v2, p0, Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem;->mFilePathView:Landroid/widget/TextView;

    .line 107
    const-string v2, "filecheck"

    invoke-static {v2, v0, v1}, Lcom/adobe/air/utils/Utils;->GetWidgetInViewByNameFromPackage(Ljava/lang/String;Landroid/content/res/Resources;Landroid/view/View;)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/CompoundButton;

    check-cast v2, Landroid/widget/CompoundButton;

    iput-object v2, p0, Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem;->mFileCheckBox:Landroid/widget/CompoundButton;

    .line 109
    iget-object v2, p0, Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem;->mFileNameView:Landroid/widget/TextView;

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem;->mFilePathView:Landroid/widget/TextView;

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem;->mFileCheckBox:Landroid/widget/CompoundButton;

    if-nez v2, :cond_0

    .line 113
    :cond_0
    invoke-static {p1, p5, p6}, Lcom/adobe/air/AIRExpandableFileChooser;->access$100(Lcom/adobe/air/AIRExpandableFileChooser;II)I

    move-result v2

    iput v2, p0, Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem;->mListFlatPosition:I

    .line 114
    new-instance v2, Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem$1;

    invoke-direct {v2, p0, p1}, Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem$1;-><init>(Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem;Lcom/adobe/air/AIRExpandableFileChooser;)V

    iput-object v2, p0, Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem;->mListener:Landroid/widget/CompoundButton$OnCheckedChangeListener;

    .line 134
    invoke-virtual {p0, v1}, Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem;->addView(Landroid/view/View;)V

    .line 148
    :goto_0
    return-void

    .line 138
    .end local v0    # "layoutResources":Landroid/content/res/Resources;
    .end local v1    # "layoutView":Landroid/view/View;
    :cond_1
    const-string v2, "expandable_chooser_row"

    invoke-static {v2, p3, p2}, Lcom/adobe/air/utils/Utils;->GetLayoutView(Ljava/lang/String;Landroid/content/res/Resources;Landroid/view/LayoutInflater;)Landroid/view/View;

    move-result-object v1

    .line 139
    .restart local v1    # "layoutView":Landroid/view/View;
    invoke-virtual {v1}, Landroid/view/View;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    .line 140
    .restart local v0    # "layoutResources":Landroid/content/res/Resources;
    const-string v2, "filename"

    invoke-static {v2, v0, v1}, Lcom/adobe/air/utils/Utils;->GetWidgetInViewByNameFromPackage(Ljava/lang/String;Landroid/content/res/Resources;Landroid/view/View;)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/TextView;

    check-cast v2, Landroid/widget/TextView;

    iput-object v2, p0, Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem;->mFileNameView:Landroid/widget/TextView;

    .line 141
    const-string v2, "filepath"

    invoke-static {v2, v0, v1}, Lcom/adobe/air/utils/Utils;->GetWidgetInViewByNameFromPackage(Ljava/lang/String;Landroid/content/res/Resources;Landroid/view/View;)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/TextView;

    check-cast v2, Landroid/widget/TextView;

    iput-object v2, p0, Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem;->mFilePathView:Landroid/widget/TextView;

    .line 143
    iget-object v2, p0, Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem;->mFileNameView:Landroid/widget/TextView;

    if-eqz v2, :cond_2

    iget-object v2, p0, Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem;->mFilePathView:Landroid/widget/TextView;

    if-nez v2, :cond_2

    .line 146
    :cond_2
    invoke-virtual {p0, v1}, Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem;->addView(Landroid/view/View;)V

    goto :goto_0
.end method

.method static synthetic access$200(Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem;)I
    .locals 1
    .param p0, "x0"    # Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem;

    .prologue
    .line 88
    iget v0, p0, Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem;->mListFlatPosition:I

    return v0
.end method


# virtual methods
.method public bindToData(Lcom/adobe/air/AIRExpandableFileChooser$FileInfo;II)V
    .locals 3
    .param p1, "info"    # Lcom/adobe/air/AIRExpandableFileChooser$FileInfo;
    .param p2, "groupPosition"    # I
    .param p3, "childPosition"    # I

    .prologue
    .line 152
    iget-object v0, p0, Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem;->mFileNameView:Landroid/widget/TextView;

    iget-object v1, p1, Lcom/adobe/air/AIRExpandableFileChooser$FileInfo;->mFileName:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 153
    iget-object v0, p0, Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem;->mFilePathView:Landroid/widget/TextView;

    iget-object v1, p1, Lcom/adobe/air/AIRExpandableFileChooser$FileInfo;->mFilePath:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 154
    iget-object v0, p0, Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem;->this$0:Lcom/adobe/air/AIRExpandableFileChooser;

    invoke-static {v0}, Lcom/adobe/air/AIRExpandableFileChooser;->access$000(Lcom/adobe/air/AIRExpandableFileChooser;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 156
    iget-object v0, p0, Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem;->this$0:Lcom/adobe/air/AIRExpandableFileChooser;

    invoke-static {v0, p2, p3}, Lcom/adobe/air/AIRExpandableFileChooser;->access$100(Lcom/adobe/air/AIRExpandableFileChooser;II)I

    move-result v0

    iput v0, p0, Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem;->mListFlatPosition:I

    .line 157
    iget-object v0, p0, Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem;->mFileCheckBox:Landroid/widget/CompoundButton;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/CompoundButton;->setOnCheckedChangeListener(Landroid/widget/CompoundButton$OnCheckedChangeListener;)V

    .line 158
    iget-object v0, p0, Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem;->mFileCheckBox:Landroid/widget/CompoundButton;

    iget-object v1, p0, Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem;->this$0:Lcom/adobe/air/AIRExpandableFileChooser;

    invoke-static {v1}, Lcom/adobe/air/AIRExpandableFileChooser;->access$300(Lcom/adobe/air/AIRExpandableFileChooser;)Landroid/util/SparseBooleanArray;

    move-result-object v1

    iget v2, p0, Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem;->mListFlatPosition:I

    invoke-virtual {v1, v2}, Landroid/util/SparseBooleanArray;->get(I)Z

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/CompoundButton;->setChecked(Z)V

    .line 159
    iget-object v0, p0, Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem;->mFileCheckBox:Landroid/widget/CompoundButton;

    iget-object v1, p0, Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem;->mListener:Landroid/widget/CompoundButton$OnCheckedChangeListener;

    invoke-virtual {v0, v1}, Landroid/widget/CompoundButton;->setOnCheckedChangeListener(Landroid/widget/CompoundButton$OnCheckedChangeListener;)V

    .line 160
    iput-object p0, p1, Lcom/adobe/air/AIRExpandableFileChooser$FileInfo;->mParent:Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem;

    .line 162
    :cond_0
    return-void
.end method

.method public toggle()V
    .locals 3

    .prologue
    .line 166
    iget-object v0, p0, Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem;->this$0:Lcom/adobe/air/AIRExpandableFileChooser;

    invoke-static {v0}, Lcom/adobe/air/AIRExpandableFileChooser;->access$000(Lcom/adobe/air/AIRExpandableFileChooser;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 168
    iget-object v1, p0, Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem;->mListener:Landroid/widget/CompoundButton$OnCheckedChangeListener;

    iget-object v2, p0, Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem;->mFileCheckBox:Landroid/widget/CompoundButton;

    iget-object v0, p0, Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem;->mFileCheckBox:Landroid/widget/CompoundButton;

    invoke-virtual {v0}, Landroid/widget/CompoundButton;->isChecked()Z

    move-result v0

    if-nez v0, :cond_1

    const/4 v0, 0x1

    :goto_0
    invoke-interface {v1, v2, v0}, Landroid/widget/CompoundButton$OnCheckedChangeListener;->onCheckedChanged(Landroid/widget/CompoundButton;Z)V

    .line 169
    iget-object v0, p0, Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem;->mFileCheckBox:Landroid/widget/CompoundButton;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/CompoundButton;->setOnCheckedChangeListener(Landroid/widget/CompoundButton$OnCheckedChangeListener;)V

    .line 170
    iget-object v0, p0, Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem;->mFileCheckBox:Landroid/widget/CompoundButton;

    iget-object v1, p0, Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem;->this$0:Lcom/adobe/air/AIRExpandableFileChooser;

    invoke-static {v1}, Lcom/adobe/air/AIRExpandableFileChooser;->access$300(Lcom/adobe/air/AIRExpandableFileChooser;)Landroid/util/SparseBooleanArray;

    move-result-object v1

    iget v2, p0, Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem;->mListFlatPosition:I

    invoke-virtual {v1, v2}, Landroid/util/SparseBooleanArray;->get(I)Z

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/CompoundButton;->setChecked(Z)V

    .line 171
    iget-object v0, p0, Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem;->mFileCheckBox:Landroid/widget/CompoundButton;

    iget-object v1, p0, Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem;->mListener:Landroid/widget/CompoundButton$OnCheckedChangeListener;

    invoke-virtual {v0, v1}, Landroid/widget/CompoundButton;->setOnCheckedChangeListener(Landroid/widget/CompoundButton$OnCheckedChangeListener;)V

    .line 173
    :cond_0
    return-void

    .line 168
    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public uncheck()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 177
    iget-object v0, p0, Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem;->this$0:Lcom/adobe/air/AIRExpandableFileChooser;

    invoke-static {v0}, Lcom/adobe/air/AIRExpandableFileChooser;->access$000(Lcom/adobe/air/AIRExpandableFileChooser;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 179
    iget-object v0, p0, Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem;->mListener:Landroid/widget/CompoundButton$OnCheckedChangeListener;

    iget-object v1, p0, Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem;->mFileCheckBox:Landroid/widget/CompoundButton;

    invoke-interface {v0, v1, v2}, Landroid/widget/CompoundButton$OnCheckedChangeListener;->onCheckedChanged(Landroid/widget/CompoundButton;Z)V

    .line 180
    iget-object v0, p0, Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem;->mFileCheckBox:Landroid/widget/CompoundButton;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/CompoundButton;->setOnCheckedChangeListener(Landroid/widget/CompoundButton$OnCheckedChangeListener;)V

    .line 181
    iget-object v0, p0, Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem;->mFileCheckBox:Landroid/widget/CompoundButton;

    invoke-virtual {v0, v2}, Landroid/widget/CompoundButton;->setChecked(Z)V

    .line 182
    iget-object v0, p0, Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem;->mFileCheckBox:Landroid/widget/CompoundButton;

    iget-object v1, p0, Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem;->mListener:Landroid/widget/CompoundButton$OnCheckedChangeListener;

    invoke-virtual {v0, v1}, Landroid/widget/CompoundButton;->setOnCheckedChangeListener(Landroid/widget/CompoundButton$OnCheckedChangeListener;)V

    .line 184
    :cond_0
    return-void
.end method
